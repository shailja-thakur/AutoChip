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

reg [6:0] branch_history;
reg [6:0] pht_index;
reg [1:0] pht_entry;

// Prediction interface
always @(posedge clk or posedge areset) begin
    if (areset)
        predict_history <= 7'b0;
    else if (predict_valid) begin
        pht_index <= predict_pc ^ branch_history;
        pht_entry <= pht_table[pht_index];
        predict_taken <= (pht_entry == 2'b00 || pht_entry == 2'b01);
        predict_history <= branch_history;    
    end
end

// Training interface
always @(posedge clk or posedge areset) begin
    if (areset)
        branch_history <= 7'b0;
    else if (train_valid) begin
        pht_index <= train_pc ^ train_history;
        pht_entry <= pht_table[pht_index];
        if (train_mispredicted) begin
            pht_table[pht_index] <= (pht_entry == 2'b11) ? 2'b10 : 2'b00;
            branch_history <= train_history;
        end else if (train_taken && pht_entry != 2'b11) begin
            pht_table[pht_index] <= pht_entry + 1;
            branch_history <= {branch_history[5:0], 1'b1};
        end else if (!train_taken && pht_entry != 2'b00) begin
            pht_table[pht_index] <= pht_entry - 1;
            branch_history <= {branch_history[5:0], 1'b0};
        end else begin
            branch_history <= train_history;
        end
    end
end

// Pattern history table
integer k;
reg [1:0] pht_table[0:127];

initial begin
    for (k = 0; k < 128; k = k + 1)
        pht_table[k] = 2'b00;
end

endmodule
