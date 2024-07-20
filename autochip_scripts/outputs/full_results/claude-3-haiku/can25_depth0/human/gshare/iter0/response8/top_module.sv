module top_module(
    input clk,
    input areset, 

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken, 
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);

    // 7-bit PC and 7-bit global history hashed into 7-bit index
    wire [6:0] index = predict_pc ^ predict_history;

    // 128-entry table of 2-bit saturating counters
    reg [1:0] pht [127:0];

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Initialize PHT to weakly not taken
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b01;
            end
            predict_history <= 7'b0;
        end
        else begin
            // Training
            if (train_valid) begin
                // Update PHT entry
                pht[train_pc ^ train_history] <= (train_taken) ? 2'b11 : 2'b00;

                // Recover branch history register on misprediction
                if (train_mispredicted) begin
                    predict_history <= train_history;
                end
            end

            // Prediction
            if (predict_valid) begin
                // Produce prediction
                predict_taken <= (pht[index] >= 2'b10);
                predict_history <= {predict_history[5:0], predict_taken};
            end
        end
    end

endmodule
