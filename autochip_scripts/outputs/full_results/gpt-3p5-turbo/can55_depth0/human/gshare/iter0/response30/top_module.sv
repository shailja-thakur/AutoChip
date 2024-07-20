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
  
  reg [6:0] ghr;
  reg [6:0] pht_index;
  reg [1:0] pht_value;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      ghr <= 0;
    end else if (train_valid) begin
      ghr <= {ghr[5:0], train_taken};
    end else if (predict_valid) begin
      ghr <= {ghr[5:0], predict_pc[6]};
    end
  end
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      pht_value <= 0;
      pht_index <= 0;
    end else if (train_valid && (train_pc == pht_index)) begin
      pht_value <= train_mispredicted ? (pht_value == 0 ? 0 : pht_value - 1) : (pht_value == 3 ? 3 : pht_value + 1);
    end else if (predict_valid && (predict_pc == pht_index)) begin
      pht_value <= pht_value;
    end
  end
  
  assign predict_taken = (pht_value == 3 || pht_value == 2);
  assign predict_history = ghr;
  
endmodule
