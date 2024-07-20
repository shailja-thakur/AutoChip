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

reg [1:0] pht[127:0]; // 128-entry 2-bit saturating counter PHT
reg [6:0] global_history;

always @(*) begin
    // Prediction logic
    if (predict_valid) begin
        // Hash PC and global history to get PHT index
        // Use XOR to hash the 7-bit PC and 7-bit global history
        // to get a 7-bit index into the 128-entry PHT
        predict_taken = (pht[predict_pc ^ global_history][1] == 1'b1);
        predict_history = global_history;
    end else begin
        // Default values when prediction is not valid
        predict_taken = 1'b0;
        predict_history = 7'b0;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01; // Initialize PHT to weakly not-taken
        end
    end
    else begin
        // Training logic
        if (train_valid) begin
            // Update PHT entry based on actual branch outcome
            pht[train_pc ^ train_history] <= (train_taken) ? 2'b11 : 2'b00;

            // Recover global history if there was a misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                // Update global history register
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
