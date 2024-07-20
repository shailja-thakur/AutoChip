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

  reg [6:0] branch_history_reg;
  wire [6:0] pht_index;
  reg [6:0] pht_entry;

  // Gshare Branch Predictor Logic
  gshare_branch_predictor GshareBranchPredictor(
    .clk(clk),
    .areset(areset),
    .predict_valid(predict_valid),
    .predict_pc(predict_pc),
    .predict_taken(predict_taken),
    .predict_history(predict_history),
    .branch_history_reg(branch_history_reg),
    .pht_index(pht_index),
    .pht_entry(pht_entry),
    .train_valid(train_valid),
    .train_taken(train_taken),
    .train_mispredicted(train_mispredicted),
    .train_history(train_history),
    .train_pc(train_pc)
  );

endmodule
module gshare_branch_predictor(
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
  input [6:0] train_pc,

  output reg [6:0] branch_history_reg,
  output wire [6:0] pht_index,
  output reg [6:0] pht_entry
);
  // Hashing the PC and History to get PHT Index
  assign pht_index = predict_pc ^ branch_history_reg;

  // PHT - Pattern History Table
  reg [1:0] pht_table [127:0];

  // Predict Direction and Update Branch History Register
  always @(posedge clk) begin
    if (areset) begin
      pht_entry <= 0;
      branch_history_reg <= 0;
    end else if (predict_valid) begin
      predict_taken <= pht_table[pht_index] > 1;
      predict_history <= branch_history_reg;
      pht_entry <= pht_table[pht_index];
      branch_history_reg <= {branch_history_reg[5:0], predict_taken};
    end else if (train_valid) begin
      pht_entry <= pht_table[pht_index];
      branch_history_reg <= train_history;
      if ((train_mispredicted && train_taken) || (!train_mispredicted && !train_taken)) begin
        pht_table[pht_index] <= pht_entry + 1'b1;
      else if (pht_entry > 0) begin
        pht_table[pht_index] <= pht_entry - 1'b1;
      end
    end
  end

endmodule
