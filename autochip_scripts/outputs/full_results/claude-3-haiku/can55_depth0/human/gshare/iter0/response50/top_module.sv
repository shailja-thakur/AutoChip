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

// 7-bit global branch history register
reg [6:0] global_history;

// 128-entry pattern history table (PHT) of 2-bit saturating counters
reg [1:0] pht[127:0];

initial begin
    global_history = 7'b0;
    for (int i = 0; i < 128; i++) begin
        pht[i] = 2'b10; // Initialize PHT to weakly not-taken
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b10;
        end
    end
    else begin
        // Prediction logic
        if (predict_valid) begin
            // Hash the PC and global history to get the PHT index
            integer index = predict_pc ^ global_history;
            predict_taken <= (pht[index[6:0]] >= 2'b10);
            predict_history <= global_history;
        end

        // Training logic
        if (train_valid) begin
            // Hash the training PC and history to get the PHT index
            integer index = train_pc ^ train_history;

            // Update the PHT based on the actual branch outcome
            if (train_taken) begin
                pht[index[6:0]] <= (pht[index[6:0]] == 2'b11) ? 2'b11 : pht[index[6:0]] + 1'b1;
            end
            else begin
                pht[index[6:0]] <= (pht[index[6:0]] == 2'b00) ? 2'b00 : pht[index[6:0]] - 1'b1;
            end

            // If the branch was mispredicted, recover the global history
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            // Otherwise, update the global history
            else begin
                global_history <= (train_taken) ? (global_history << 1) | 1'b1 : (global_history << 1);
            end
        end
    end
end

endmodule
