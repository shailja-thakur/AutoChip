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

    // Define a 128-entry table of 2-bit saturating counters
    reg [1:0] PHT[127:0];
    // 7-bit global branch history register
    reg [6:0] GHR;

    // Define combinational logic to calculate indexes
    wire [6:0] predict_index = predict_pc ^ GHR;
    wire [6:0] train_index = train_pc ^ train_history;

    // Initialization block
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b10; // Weakly taken
            end
            GHR <= 7'b0;
        end
        else if (train_valid) begin
            // Update the saturating counter
            if (train_taken) begin
                if (PHT[train_index] < 2'b11)
                    PHT[train_index] <= PHT[train_index] + 1;
            end else begin
                if (PHT[train_index] > 2'b00)
                    PHT[train_index] <= PHT[train_index] - 1;
            end

            // If it's a misprediction, recover GHR
            if (train_mispredicted) begin
                GHR <= train_history;
            end else begin
                // Update GHR with actual branch outcome
                GHR <= {train_history[5:0], train_taken};
            end
        end
    end

    // Prediction logic
    always @(posedge clk or posedge areset) begin
        if (!areset && predict_valid) begin
            // Get the prediction from the PHT
            predict_taken <= (PHT[predict_index] >= 2'b10);
            
            // Update GHR speculatively with predicted outcome
            GHR <= {GHR[5:0], predict_taken};
        end else if (areset) begin
            predict_taken <= 1'b0;
            predict_history <= 7'b0;
        end
    end

    // Provide prediction history register used for prediction
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 7'b0;
        end else if (predict_valid) begin
            predict_history <= GHR;
        end
    end

endmodule
