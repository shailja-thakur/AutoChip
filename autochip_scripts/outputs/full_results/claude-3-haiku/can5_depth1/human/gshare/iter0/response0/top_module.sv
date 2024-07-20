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

reg [1:0] pht[127:0]; // 128-entry pattern history table
reg [6:0] global_history; // 7-bit global branch history register

// Prediction logic
always @(*) begin
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        integer index = predict_pc ^ global_history;
        // Make the prediction based on the PHT entry
        predict_taken = (pht[index[6:0]] >= 2'b10);
        predict_history = global_history;
    end else begin
        predict_taken = 1'b0;
        predict_history = 7'b0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b01; // Initialize PHT to weakly not taken
        end
    end else begin
        if (train_valid) begin
            // Hash the PC and global history to get the PHT index
            integer index = train_pc ^ train_history;
            // Update the PHT entry based on the actual branch outcome
            if (train_taken) begin
                pht[index[6:0]] <= (pht[index[6:0]] == 2'b00) ? 2'b01 : (pht[index[6:0]] + 1'b1);
            end else begin
                pht[index[6:0]] <= (pht[index[6:0]] == 2'b11) ? 2'b10 : (pht[index[6:0]] - 1'b1);
            end
            // If the branch was mispredicted, recover the global history
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                // Update the global history register
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
