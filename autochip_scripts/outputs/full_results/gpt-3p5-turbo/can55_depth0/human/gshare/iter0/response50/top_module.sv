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
  
  reg [1:0] pattern_history_table[0:127];
  reg [1:0] branch_history_register;
  
  reg predict_taken_reg;
  reg [6:0] predict_history_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      pattern_history_table <= 2'b00;
      branch_history_register <= 0;
    end else begin
      if (train_valid) begin
        pattern_history_table[train_pc ^ train_history] <= train_taken;
        if (train_mispredicted) begin
          branch_history_register <= train_history;
        end
      end
      
      if (predict_valid) begin
        predict_taken_reg <= pattern_history_table[predict_pc ^ branch_history_register][1];
        predict_history_reg <= branch_history_register;
      end
    end
  end
  
  assign predict_taken = predict_taken_reg;
  assign predict_history = predict_history_reg;
  
endmodule
