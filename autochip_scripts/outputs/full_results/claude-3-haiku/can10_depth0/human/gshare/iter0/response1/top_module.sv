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

reg [1:0] pht [127:0]; // 128-entry pattern history table
reg [6:0] global_history; // 7-bit global branch history register

always @(*) begin
    // Prediction logic
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        predict_history = global_history;
        predict_taken = pht[predict_pc ^ global_history][1]; // Most significant bit is the prediction
    end
    else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01; // Initialize all PHT entries to weakly not taken
        end
    end
    else begin
        // Training logic
        if (train_valid) begin
            // Update the PHT entry based on the actual branch outcome
            if (train_taken) begin
                pht[train_pc ^ train_history] <= (pht[train_pc ^ train_history] == 2'b11) ? 2'b11 : pht[train_pc ^ train_history] + 1; // Saturating increment
            end
            else begin
                pht[train_pc ^ train_history] <= (pht[train_pc ^ train_history] == 2'b00) ? 2'b00 : pht[train_pc ^ train_history] - 1; // Saturating decrement
            end

            // Update the global history register
            if (train_mispredicted) begin
                // Recover the global history to the state immediately after the mispredicting branch
                global_history <= train_history;
            end
            else begin
                // Shift the global history register and insert the actual branch outcome
                global_history <= (global_history << 1) | train_taken;
            end
        end
        else begin
            // Update the global history register with the predicted branch outcome
            global_history <= (global_history << 1) | predict_taken;
        end
    end
end

endmodule
