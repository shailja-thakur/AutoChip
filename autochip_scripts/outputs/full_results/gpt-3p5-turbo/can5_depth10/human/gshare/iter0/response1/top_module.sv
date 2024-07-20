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
  reg predict_taken_reg;
  wire [6:0] index;
  wire [1:0] counter_value;
  
  reg [1:0] pattern_history_table [0:127];
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      global_history_reg <= 0;
    end else if (train_valid) begin
      global_history_reg <= {global_history_reg[5:0], train_taken};
    end else if (predict_valid) begin
      global_history_reg <= {global_history_reg[5:0], predict_taken_reg};
    end
  end
  
  assign index = predict_pc ^ global_history_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      predict_taken_reg <= 0;
    end else if (train_valid && train_pc == predict_pc) begin
      predict_taken_reg <= train_taken;
    end else if (predict_valid && index < 128) begin
      predict_taken_reg <= (pattern_history_table[index] > 1);
    end
  end
  
  always @(posedge clk) begin
    if (train_valid && train_pc == predict_pc) begin
      if (train_mispredicted) begin
        pattern_history_table[index] <= pattern_history_table[index] - 1;
      end else begin
        pattern_history_table[index] <= pattern_history_table[index] + 1;
      end
    end
  end
  
  assign predict_taken = predict_taken_reg;
  assign predict_history = global_history_reg;

endmodule
