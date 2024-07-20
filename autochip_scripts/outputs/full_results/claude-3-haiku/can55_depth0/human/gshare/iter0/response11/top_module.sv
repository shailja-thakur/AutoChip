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

reg [1:0] pht[127:0]; // Pattern History Table
reg [6:0] global_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (integer i = 0; i < 128; i++) begin
            pht[i] <= 2'b01; // Initialize all entries to weakly not taken
        end
    end
    else begin
        // Prediction Logic
        if (predict_valid) begin
            // Hash the PC and global history to get the PHT index
            integer index = predict_pc ^ global_history;
            predict_taken = pht[index[6:0]] >= 2'b10; // Predict taken if counter is >= 2
            predict_history = global_history;
        end

        // Training Logic
        if (train_valid) begin
            // Hash the training PC and history to get the PHT index
            integer index = train_pc ^ train_history;

            // Update the PHT entry based on the actual branch outcome
            if (train_taken) begin
                pht[index[6:0]] = (pht[index[6:0]] == 2'b11) ? 2'b11 : pht[index[6:0]] + 1; // Saturating increment
            end
            else begin
                pht[index[6:0]] = (pht[index[6:0]] == 2'b00) ? 2'b00 : pht[index[6:0]] - 1; // Saturating decrement
            end

            // If the branch was mispredicted, recover the global history
            if (train_mispredicted) begin
                global_history = train_history;
            end
            else begin
                global_history = (global_history << 1) | train_taken; // Update global history
            end
        end
    end
end

endmodule
