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
  reg [1:0] pht [0:127];
  reg predict_taken;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      history_reg <= 0;
    else if (predict_valid)
      history_reg <= predict_history;
    else if (train_valid)
      history_reg <= train_history;
  end
  
  always @(posedge clk) begin    
    if (predict_valid)
      index <= predict_pc ^ history_reg;
    
    if (train_valid && train_mispredicted) begin
      if (index == train_pc)
        pht[index] <= pht[index] - 1;
      
      history_reg <= train_history;
    end else if (predict_valid)
      predict_taken <= (pht[index] == 3'b11 || pht[index] == 3'b10);
    
    if (train_valid && !train_mispredicted) begin
      if (index == train_pc)
        pht[index] <= pht[index] + 1;
      
      history_reg <= train_history;
    end
  end
  
endmodule
