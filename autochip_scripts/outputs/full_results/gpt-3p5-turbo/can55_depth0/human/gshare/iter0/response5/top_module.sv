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
  reg [6:0] index;
  reg [1:0] pht [0:127]; // Pattern History Table
  reg [1:0] predict_state;
  reg predict_taken_reg;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      ghr <= 0;
      index <= 0;
      pht <= 0;
      predict_taken_reg = 0;
      predict_state = 0;
    end else begin
      if (train_valid) begin
        index <= train_pc ^ ghr;
        pht[index] <= train_taken ? (train_mispredicted ? 0 : pht[index] + 1) : (train_mispredicted ? 3 : pht[index] - 1);
        ghr <= {train_history[5:0], train_taken};
      end
      if (predict_valid) begin
        index <= predict_pc ^ ghr;
        predict_taken_reg <= predict_state[1];
        predict_state <= pht[index];
        predict_history <= ghr;
      end
    end
  end

  assign predict_taken = predict_taken_reg;

endmodule
