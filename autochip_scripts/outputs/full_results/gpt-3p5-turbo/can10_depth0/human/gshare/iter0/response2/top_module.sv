module top_module(
    input clk,
    input areset, 
 
    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken, 
    output [6:0] predict_history,
 
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);
 
// Define constants
parameter TABLE_SIZE = 128;
parameter PC_WIDTH = 7;
parameter HISTORY_WIDTH = 7;
parameter INDEX_WIDTH = 7;
parameter COUNTER_WIDTH = 2;
 
// Declare signals and registers
reg [PC_WIDTH-1:0] counter;
reg [HISTORY_WIDTH-1:0] history_register;
reg [COUNTER_WIDTH-1:0] prediction_table [0:TABLE_SIZE-1];
wire [INDEX_WIDTH-1:0] index;
reg predict_taken;
 
// Define XOR function for hashing
function [INDEX_WIDTH-1:0] xor_hash;
    input [PC_WIDTH-1:0] pc;
    input [HISTORY_WIDTH-1:0] history;
    begin
        xor_hash = pc ^ history;
    end
endfunction
 
// Assign signals and registers
assign index = xor_hash(predict_pc, history_register);
assign predict_taken = prediction_table[index] >= 2;
assign predict_history = history_register;
 
// Training process
always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter <= 0;
    end else if (predict_valid) begin
        counter <= counter + 1;
    end else if (train_valid) begin
        counter <= 0;
    end
end
 
// Update prediction table and history register
always @(posedge clk or posedge areset) begin
    if (areset) begin
        history_register <= 0;
        for (int i = 0; i < TABLE_SIZE; i = i + 1) begin
            prediction_table[i] <= 0;
        end
    end else if (train_valid) begin
        history_register <= train_history;
        if (train_mispredicted) begin
            prediction_table[index] <= (prediction_table[index] == 3) ? 0 : 1;
        end
        if (train_taken) begin
            prediction_table[index] <= (prediction_table[index] == 2 || prediction_table[index] == 3) ? 3 : 2;
        end else begin
            prediction_table[index] <= (prediction_table[index] == 1 || prediction_table[index] == 2) ? 0 : 1;
        end
    end else if (predict_valid) begin
        history_register <= {history_register[HISTORY_WIDTH-2:0], predict_taken};
    end
end
 
endmodule
