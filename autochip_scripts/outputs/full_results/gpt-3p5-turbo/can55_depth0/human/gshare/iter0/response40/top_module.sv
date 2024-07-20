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

  reg [6:0] global_history;
  reg [127:0] pht [0:127]; // Pattern History Table
  reg [1:0] counter;

  // Predict branch direction and get branch history register's state
  always @(posedge clk or posedge areset) begin
    if (areset)
      global_history <= 0;
    else if (predict_valid) begin
      predict_history <= global_history;
      if (pht[predict_pc ^ global_history] >= 2)
        predict_taken <= 1;
      else
        predict_taken <= 0;
    end
  end

  // Update branch history register and pattern history table
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      global_history <= 0;
      pht <= 0;
    end else if (train_valid) begin
      global_history <= train_history;
      if (train_mispredicted && pht[train_pc ^ train_history] < 3) begin
        global_history <= train_history; // Recover branch history register
        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1; // Update PHT based on actual outcome
      end else if (train_taken && pht[train_pc ^ train_history] < 3) begin
        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1; // Update PHT based on actual outcome
      end else if (!train_taken && pht[train_pc ^ train_history] > 0) begin
        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1; // Update PHT based on actual outcome
      end
    end
  end

endmodule
