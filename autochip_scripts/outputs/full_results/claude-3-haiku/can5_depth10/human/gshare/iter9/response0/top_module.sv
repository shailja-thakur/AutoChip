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

integer i;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b10;
        end
    end
    else begin
        // Update branch history register
        if (train_valid) begin
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                global_history <= (global_history << 1) | train_taken;
            end
        end
        else if (predict_valid) begin
            global_history <= (global_history << 1) | predict_taken;
        end

        // Train the pattern history table
        if (train_valid) begin
            pht[train_pc ^ global_history[6:0]] <= (train_taken) ? (pht[train_pc ^ global_history[6:0]] == 2'b11 ? 2'b11 : pht[train_pc ^ global_history[6:0]] + 1'b1) : (pht[train_pc ^ global_history[6:0]] == 2'b00 ? 2'b00 : pht[train_pc ^ global_history[6:0]] - 1'b1);
        end
    end
end

// Predict branch direction
always @* begin
    if (predict_valid) begin
        predict_taken <= pht[predict_pc ^ global_history[6:0]][1];
        predict_history <= global_history;
    end
    else begin
        predict_taken <= 1'b0;
        predict_history <= 7'b0;
    end
end

endmodule
