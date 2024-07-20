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

reg [6:0] history_register;
reg [6:0] index;
reg [1:0] counter [0:127];

always @(posedge clk or posedge areset) begin
  if (areset) begin
    history_register <= 0;
    counter <= (2'b00);
  end else begin
    if (predict_valid) begin
      index <= predict_pc ^ history_register;
      predict_taken <= (counter[index] == 2'b11 || counter[index] == 2'b10);
      predict_history <= history_register;
    end else if (train_valid) begin
      index <= train_pc ^ train_history;
      counter[index] <= counter[index] + (train_taken ? 2'b01 : 2'b00);
      if (train_mispredicted) begin
        history_register <= train_history;
      end
    end
  end
end

endmodule
