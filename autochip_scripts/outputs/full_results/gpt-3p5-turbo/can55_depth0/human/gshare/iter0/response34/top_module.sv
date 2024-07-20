module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // Define parameters
    parameter int PHT_SIZE = 128;
    parameter int PHT_ENTRY_WIDTH = 2;
    parameter int PC_WIDTH = 7;
    parameter int HISTORY_WIDTH = 7;
    parameter int INDEX_WIDTH = 7;
    parameter int GHR_WIDTH = 7;

    // Define signals
    reg [INDEX_WIDTH-1:0] index;
    reg [GHR_WIDTH-1:0] ghr;
    reg [PHT_SIZE-1:0][PHT_ENTRY_WIDTH-1:0] pht;
    reg predict_taken_reg;
    reg [GHR_WIDTH-1:0] predict_history_reg;

    // Clock edge detection
    always @(posedge clk) begin
        if (areset) begin
            // Reset the predictor
            index <= 0;
            ghr <= 0;
            predict_taken_reg <= 0;
            predict_history_reg <= 0;
            pht <= (PHT_ENTRY_WIDTH'b0);
        end else begin
            // Update the prediction and training
            if (predict_valid) begin
                // Make prediction
                index <= predict_pc ^ ghr;
                predict_taken_reg <= (pht[index] >= PHT_ENTRY_WIDTH'b2);
                predict_history_reg <= ghr;
            end

            if (train_valid) begin
                // Train the predictor
                index <= train_pc ^ train_history;
                if (train_mispredicted) begin
                    // Misprediction, flush the pipeline
                    predict_taken_reg <= train_taken;
                end
                pht[index] <= $signed(pht[index]) + (train_taken ? 1 : -1);
                ghr <= {ghr[HISTORY_WIDTH-2:0], train_taken};
            end
        end
    end

    // Assign predictions and history outputs
    assign predict_taken = predict_taken_reg;
    assign predict_history = predict_history_reg;

endmodule
