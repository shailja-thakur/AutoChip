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
 
 reg [6:0] history;

 // Hash the pc and history into an index for the prediction table
 // using xor operation
 reg [6:0] index;
 always @(posedge clk or posedge areset) begin
  if (areset)
   index <= 0;
  else if (predict_valid)
   index <= predict_pc ^ history;
  else if (train_valid)
   index <= train_pc ^ train_history;
 end

 // 128-entry table of two-bit saturating counters
 reg [1:0] pred_table [0:127];
 always @(posedge clk or posedge areset) begin
  if (areset) begin
   for (integer i = 0; i <= 127; i = i + 1)
    pred_table[i] <= 0;
  end else if (train_valid) begin
   if (train_mispredicted)
    pred_table[index] <= pred_table[index] - (history[0] ? 1 : 0);
   else
    pred_table[index] <= pred_table[index] + (train_taken ? 1 : 0);
  end
 end

 // Update the history register at the next positive clock edge
 always @(posedge clk) begin
  if (areset)
   history <= 0;
  else
   history <= {history[5:0], train_taken};
 end

 // Prediction interface
 always @(predict_valid or predict_pc or history) begin
  if (predict_valid)
   predict_taken <= pred_table[index][1];
  else
   predict_taken <= 0;

  predict_history <= history;
 end
endmodule
