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

reg [6:0] ghr;  // Global history register
reg [6:0] pht_index;  // Index into PHT
reg [1:0] pht_state;  // State stored in PHT
reg predict_taken_reg;  // Predicted branch direction

reg predict_taken_reg_next;  // Future value of predict_taken_reg
reg [6:0] predict_history_next;  // Future value of predict_history

reg train_taken_reg_next;  // Future value of train_taken_reg

// PHT contains 128 entries of 2-bit saturating counters
reg [1:0] pht [127:0];

always @(posedge clk or posedge areset) begin
  if (areset) begin
    ghr <= 7'b0;
    pht_index <= 7'b0;
    pht_state <= 2'b0;
    predict_taken_reg <= 1'b0;
  end else begin
    if (train_valid) begin
      ghr <= train_history;
      pht_index <= train_pc ^ ghr;
      pht_state <= pht[pht_index];
      if (train_mispredicted) begin
        ghr <= ghr >> 1;
        ghr[6] <= train_taken;
      end
      pht[pht_index] <= pht_state + (train_taken ? 1 : -1);
    end else if (predict_valid) begin
      ghr <= ghr >> 1;
      ghr[6] <= predict_taken_reg_next;
      pht_index <= predict_pc ^ ghr;
      predict_taken_reg <= pht[pht_index][1];
      predict_history <= ghr;
    end
  end
end

assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_next;

endmodule
