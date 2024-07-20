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
   
   reg [6:0] global_history;
   reg [6:0] predict_history;
   reg predict_taken;

   // Hash function for index calculation
   function [6:0] hash;
       input [6:0] input_value;
       begin
           hash = predict_pc ^ global_history;
       end
   endfunction

   // Pattern History Table
   reg [1:0] pattern_history_table [0:127];

   always @(posedge clk or posedge areset) begin
       if (areset) begin
           global_history <= 0;
       end else if (train_valid) begin
           global_history <= train_history;
       end
   end

   always @(posedge clk) begin
       if (predict_valid) begin
           predict_history <= global_history;
           if (pattern_history_table[hash(predict_pc)] == 2'b01 || pattern_history_table[hash(predict_pc)] == 2'b11) begin
               predict_taken <= 1;
           end else begin
               predict_taken <= 0;
           end
       end
   end

   always @(posedge clk) begin
       if (train_valid && !train_mispredicted) begin
           pattern_history_table[hash(train_pc)] <= pattern_history_table[hash(train_pc)] + 1;
       end else if (train_valid && train_mispredicted) begin
           pattern_history_table[hash(train_pc)] <= pattern_history_table[hash(train_pc)] - 1;
           global_history <= train_history;
       end
   end

endmodule
