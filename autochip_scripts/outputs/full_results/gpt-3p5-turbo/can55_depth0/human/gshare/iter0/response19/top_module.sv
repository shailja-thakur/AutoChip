module top_module(
  input wire clk,
  input wire areset,

  input wire predict_valid,
  input wire [6:0] predict_pc,
  output wire predict_taken,
  output wire [6:0] predict_history,

  input wire train_valid,
  input wire train_taken,
  input wire train_mispredicted,
  input wire [6:0] train_history,
  input wire [6:0] train_pc
);
  reg [6:0] global_history;
  reg [6:0] index;
  reg [1:0] sat_counter [0:127];

  always @(posedge clk or posedge areset) begin
    if (areset)
      global_history <= 0;
    else if (train_valid) begin
      index <= train_pc ^ global_history;
      if (train_mispredicted) begin
        global_history <= train_history;
        sat_counter[index] <= 2'd0; // always reset to not taken for misprediction
      end else begin
        global_history <= {global_history[5:0], train_taken};
        if (predict_valid && predict_pc == train_pc)
          predict_taken <= train_taken;
        else
          predict_taken <= sat_counter[index] > 1;
        sat_counter[index] <= sat_counter[index] + (train_taken ? 1 : -1);
      end
    end else if (predict_valid) begin
      index <= predict_pc ^ global_history;
      predict_taken <= sat_counter[index] > 1;
    end
  end

  assign predict_history = global_history;

endmodule
