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

reg [6:0] history_reg;
reg [6:0] index;
reg [1:0] counter;
reg predict_taken;
reg [6:0] predict_history;

always @(posedge clk or posedge areset) begin
  if (areset)
    history_reg <= 7'b0;
  else if (predict_valid)
    history_reg <= {history_reg[5:0], predict_taken};
  else if (train_valid)
    history_reg <= {train_history[5:0], train_taken};
end

assign index = predict_pc ^ history_reg;
assign predict_taken = counter[1];

always @(posedge clk or posedge areset) begin
  if (areset)
    counter <= 2'b0;
  else if (predict_valid)
    counter <= counter + 1;
  else if (train_valid)
    counter <= counter - (counter != 2'b00);
end

always @(posedge clk or posedge areset) begin
  if (areset)
    predict_history <= 7'b0;
  else if (predict_valid)
    predict_history <= history_reg;
end

endmodule
