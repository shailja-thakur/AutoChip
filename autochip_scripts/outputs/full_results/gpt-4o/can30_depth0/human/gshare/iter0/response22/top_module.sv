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

    reg [1:0] PHT [127:0]; // 128-entry table of 2-bit saturating counters
    reg [6:0] GHR; // 7-bit global history register

    // PHT initialization
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01; // Weakly not taken state
        end
    end

    // Updating the PHT counter
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
        end else if (train_valid) begin
            // Update branch history register if mispredicted
            if (train_mispredicted) begin
                GHR <= train_history;
            end else begin
                GHR <= {GHR[5:0], train_taken}; // Update GHR with actual branch outcome
            end

            // Train the PHT based on actual outcome
            if (train_taken) begin
                if (PHT[train_pc ^ train_history] < 2'b11)
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
            end else begin
                if (PHT[train_pc ^ train_history] > 2'b00)
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
            end
        end else if (predict_valid) begin
            GHR <= {GHR[5:0], PHT[predict_pc ^ GHR][1]}; // Update GHR with prediction (for speculative history)
        end
    end

    // Prediction logic
    always @* begin
        predict_taken = PHT[predict_pc ^ GHR][1];
        predict_history = GHR;
    end

endmodule
