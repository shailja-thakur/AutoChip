module top_module (
  input clk,
  input areset,

  input  predict_valid,
  input  [6:0] predict_pc,
  output predict_taken,
  output [6:0] predict_history,

  input train_valid,
  input train_taken,
  input train_mispredicted,
  input [6:0] train_history,
  input [6:0] train_pc
);

  reg [6:0] pc;
  reg [6:0] history;
  reg [6:0] global_history;
  reg [1:0] saturating_counter [128];

  always @(posedge clk or negedge areset) begin
    if (areset) begin
      pc <= 0;
      history <= 0;
      global_history <= 0;
      for (int i = 0; i < 128; i++) begin
        saturating_counter[i] <= 2'b01;
      end
    end else begin
      if (predict_valid) begin
        predict_taken <= saturating_counter[xor(pc, global_history)];
      end
      if (train_valid) begin
        if (train_mispredicted) begin
          global_history <= history;
        end
        saturating_counter[xor(train_pc, global_history)] <= saturating_counter[xor(train_pc, global_history)] + (train_taken ? 1 : -1);
      end
      pc <= predict_pc;
      history <= train_history;
    end
  end

  assign predict_history = history;

endmodule