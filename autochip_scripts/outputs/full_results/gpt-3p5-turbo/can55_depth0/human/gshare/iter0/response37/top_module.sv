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
  
  reg [6:0] pc_reg;
  reg [6:0] history_reg;
  reg [6:0] index;
  reg [1:0] counter_value;
  reg [1:0] pht_table [0:127];
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      pc_reg <= 7'b0;
    else
      pc_reg <= predict_valid ? predict_pc : train_pc;
      
    if (areset)
      history_reg <= 7'b0;
    else
      history_reg <= train_valid ? train_history : {history_reg[5:0], train_taken};
    
    index <= pc_reg ^ history_reg;
    
    if (predict_valid)
      predict_taken <= pht_table[index] > 1;
    else
      predict_taken <= 1'bx;
  
    predict_history <= history_reg;
    
    if (train_valid) begin
      if (train_mispredicted) begin
        pht_table[index] <= pht_table[index] <= train_taken ? 3'b000 : 3'b011;
        history_reg <= train_history;
      end else begin
        pht_table[index] <= train_taken ? pht_table[index] + 1 : pht_table[index] - 1;
      end
    end
  end
  
endmodule
