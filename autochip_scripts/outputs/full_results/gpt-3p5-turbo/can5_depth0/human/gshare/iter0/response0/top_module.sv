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

reg [6:0] branch_history;
reg [6:0] index;
reg [1:0] counter [0:127];

// Branch predictor logic
always @(posedge clk or posedge areset) begin
  if (areset) begin
    branch_history <= 0;
    index <= 0;
    for (int i = 0; i < 128; i = i + 1) begin
      counter[i] <= 0;
    end
  end else begin
    if (predict_valid) begin
      index <= predict_pc ^ branch_history;
      predict_taken <= counter[index] > 1 ? 1 : 0;
      predict_history <= branch_history;
    end else if (train_valid) begin
      index <= train_pc ^ train_history;
      if (train_mispredicted) begin
        branch_history <= train_history;
        counter[index] <= train_taken ? 0 : 3;
      end else begin
        counter[index] <= train_taken ? counter[index] < 3 ? counter[index] + 1 : 3 : counter[index] > 0 ? counter[index] - 1 : 0;
      end
    end
  end
end

endmodule
