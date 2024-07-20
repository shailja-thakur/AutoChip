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

// Declare the pattern history table (PHT)
reg [1:0] pht[127:0];

// Declare the global branch history register
reg [6:0] global_history;

// Prediction logic
always @(*) begin
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        // This can be done using XOR as mentioned in the problem statement
        integer pht_index = predict_pc ^ global_history;
        // Get the predicted branch direction from the PHT
        predict_taken = pht[pht_index][1];
        // Output the current global history
        predict_history = global_history;
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b10;
        end
    end else begin
        if (train_valid) begin
            integer pht_index = train_pc ^ train_history;
            // Update the PHT entry based on the actual branch outcome
            if (train_taken) begin
                pht[pht_index] <= (pht[pht_index] == 2'b00) ? 2'b00 : (pht[pht_index] - 1);
            end else begin
                pht[pht_index] <= (pht[pht_index] == 2'b11) ? 2'b11 : (pht[pht_index] + 1);
            end
            // Update the global history register
            global_history <= (train_taken) ? (global_history << 1 | 1) : (global_history << 1);
            // If the branch was mispredicted, recover the global history register
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end
    end
end

endmodule
