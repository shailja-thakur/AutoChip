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

  // Define constants
  parameter INDEX_WIDTH = 7;
  parameter TABLE_SIZE = 128;
  parameter GLOBAL_HISTORY_WIDTH = 7;
  parameter COUNTER_WIDTH = 2;
  
  // Internal signals and registers
  reg [GLOBAL_HISTORY_WIDTH-1:0] global_history;
  reg [TABLE_SIZE-1:0] pattern_history_table [COUNTER_WIDTH-1:0];
  reg [INDEX_WIDTH-1:0] index;
  reg predict_taken_internal;
  reg [GLOBAL_HISTORY_WIDTH-1:0] predict_history_internal;
  
  // Predict branch direction and state of the branch history register
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      global_history <= 0;
      index <= 0;
      predict_taken_internal <= 0;
      predict_history_internal <= 0;
    end else begin
      if (predict_valid) begin
        index <= predict_pc ^ global_history;
        predict_taken_internal <= (pattern_history_table[index] >= 2);
        predict_history_internal <= global_history;
      end
    end
  end
  
  // Update branch history register and pattern history table
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      global_history <= 0;
      for (integer i = 0; i < TABLE_SIZE; i = i + 1) begin
        pattern_history_table[i] <= 0;
      end
    end else begin
      if (train_valid) begin
        global_history <= {global_history[GLOBAL_HISTORY_WIDTH-2:0], train_taken};
        if (train_mispredicted) begin
          global_history <= train_history;
        end
        pattern_history_table[train_pc ^ train_history] <= $signed(pattern_history_table[train_pc ^ train_history]) + (train_taken ? 1 : -1);
      end
    end
  end
  
  // Output prediction signals
  assign predict_taken = predict_taken_internal;
  assign predict_history = predict_history_internal;

endmodule
