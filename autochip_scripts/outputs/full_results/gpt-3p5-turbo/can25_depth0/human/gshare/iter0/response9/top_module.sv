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

  reg [6:0] global_history_reg;
  reg [6:0] predict_index;
  reg [1:0] predict_state;
  
  reg [6:0] train_index;
  reg [1:0] train_state;
  
  reg [6:0] pht [0:127];
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      global_history_reg <= 7'b0000000;
      predict_index <= 7'b0000000;
      predict_state <= 2'b00;
      train_index <= 7'b0000000;
      train_state <= 2'b00;
      
      for (int i = 0; i < 128; i = i + 1) begin
        pht[i] <= 2'b00;
      end
    end else begin
      global_history_reg <= {global_history_reg[5:0], predict_taken};
      
      if (predict_valid) begin
        predict_index <= predict_pc ^ global_history_reg[6:0];
        predict_state <= pht[predict_index];
      end
      
      if (train_valid) begin
        train_index <= train_pc ^ train_history;
        train_state <= pht[train_index];
      end
    end
  end
  
  always @(posedge clk) begin
    if (train_valid) begin
      pht[train_index] <= 
        (train_mispredicted && (train_state < 2'b11)) ? train_state + 2'b10 :
        (!train_mispredicted && (train_state > 2'b00)) ? train_state - 2'b10 : train_state;
    end
    
    if (predict_valid) begin
      predict_taken <= predict_state[1];
      predict_history <= global_history_reg;
    end
  end

endmodule
