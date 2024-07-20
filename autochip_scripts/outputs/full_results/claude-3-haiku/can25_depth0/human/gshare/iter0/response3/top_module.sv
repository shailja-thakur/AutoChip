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

localparam PHT_SIZE = 128;
reg [1:0] pht[PHT_SIZE-1:0];
reg [6:0] global_history;

initial begin
    predict_taken = 0;
    predict_history = 0;
    global_history = 0;
    for (int i = 0; i < PHT_SIZE; i++) begin
        pht[i] = 2'b01;
    end
end

always @(*) begin
    if (predict_valid) begin
        // Hash PC and global history to get PHT index
        int pht_index = (predict_pc ^ global_history) % PHT_SIZE;
        // Make prediction based on PHT entry
        predict_taken = (pht[pht_index] >= 2'b10);
        predict_history = global_history;
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
    end else begin
        if (train_valid) begin
            // Update PHT entry based on actual branch outcome
            int pht_index = (train_pc ^ train_history) % PHT_SIZE;
            if (train_taken) begin
                pht[pht_index] <= (pht[pht_index] == 2'b11) ? 2'b11 : pht[pht_index] + 1;
            end else begin
                pht[pht_index] <= (pht[pht_index] == 2'b00) ? 2'b00 : pht[pht_index] - 1;
            end
            
            // Update global history register
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
