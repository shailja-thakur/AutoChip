module gshare_branch_predictor (
  input clk,                   // Clock signal
  input reset,                 // Reset signal

  input predict_valid,         // Valid signal for prediction
  input [6:0] predict_pc,      // PC for prediction
  output predict_taken,        // Predicted branch direction
  output [6:0] predict_history,// Branch history register used for prediction

  input train_valid,           // Valid signal for training
  input train_taken,           // Actual branch outcome
  input train_mispredicted,    // Whether the branch was mispredicted
  input [6:0] train_history,   // Branch history register value for training
  input [6:0] train_pc         // PC for training
);

  reg [6:0] global_history;    // Global branch history register
  reg [6:0] predict_index;     // Index for accessing the pattern history table
  reg [1:0] pattern_history_table [0:127];  // Pattern history table
  reg predict_taken_reg;       // Register for storing predicted branch direction
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      global_history <= 7'b0;   // Reset global branch history register
      pattern_history_table <= 128'd0;  // Reset pattern history table
    end else begin
      if (predict_valid) begin
        predict_index <= predict_pc ^ global_history;  // Compute index
      end
      if (train_valid && !train_mispredicted) begin
        // Update pattern history table for training
        pattern_history_table[train_pc ^ train_history] <= pattern_history_table[train_pc ^ train_history] + (train_taken ? 1 : -1);
      end
      if (predict_valid) begin
        // Retrieve predicted branch direction and branch history register value
        predict_taken_reg <= (pattern_history_table[predict_index] >= 2'b10);
      end
      if (train_valid && train_mispredicted) begin
        // Update pattern history table and recover branch history register for misprediction
        pattern_history_table[train_pc ^ train_history] <= pattern_history_table[train_pc ^ train_history] - (train_taken ? 1 : -1);
        global_history <= train_history;
      end
    end
  end
  
  assign predict_taken = predict_taken_reg;
  assign predict_history = global_history;
  
endmodule
module top_module (
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
  
  wire predict_taken_wire;
  wire [6:0] predict_history_wire;
  
  gshare_branch_predictor gshare_predictor (
    .clk(clk),
    .reset(areset),
    .predict_valid(predict_valid),
    .predict_pc(predict_pc),
    .predict_taken(predict_taken_wire),
    .predict_history(predict_history_wire),
    
    .train_valid(train_valid),
    .train_taken(train_taken),
    .train_mispredicted(train_mispredicted),
    .train_history(train_history),
    .train_pc(train_pc)
  );
  
  // Connect output signals
  assign predict_taken = predict_taken_wire;
  assign predict_history = predict_history_wire;
  
endmodule
