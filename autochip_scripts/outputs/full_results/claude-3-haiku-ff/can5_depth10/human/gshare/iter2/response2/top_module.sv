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

initial begin
    integer i;
    for (i = 0; i < 128; i = i + 1) begin
        pht[i] <= 2'b10; // Initialize PHT to weakly not-taken
    end
    global_history <= 7'b0; // Initialize global history to all 0s
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b10; // Reset PHT to weakly not-taken
        end
    end
    else begin
        if (train_valid) begin
            // Train the branch predictor
            pht[train_pc[6:0] ^ global_history] <= (train_taken) ? 2'b11 : 2'b00;
            global_history <= {global_history[5:0], train_taken};
        end
        else if (predict_valid) begin
            // Predict the branch direction
            predict_taken <= pht[predict_pc[6:0] ^ global_history][1];
            predict_history <= global_history;
            // Update the global history register
            global_history <= {global_history[5:0], predict_taken};
        end
    end
end

endmodule
