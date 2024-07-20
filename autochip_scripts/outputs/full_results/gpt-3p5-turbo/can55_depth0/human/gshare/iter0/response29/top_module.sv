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

  // Constants
  parameter TABLE_SIZE = 128;
  parameter COUNTER_SIZE = 2;

  // Internal signals
  reg [6:0] indexed_pc;
  reg [6:0] indexed_history;
  reg [1:0] counter;
  reg [6:0] updated_history;

  // Pattern History Table (PHT)
  reg [COUNTER_SIZE-1:0] pht[TABLE_SIZE];

  // Predict
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      predict_taken <= 0;
      predict_history <= 0;
    end else if (predict_valid) begin
      indexed_pc <= predict_pc;
      indexed_history <= predict_history;

      // Get the counter value from PHT using indexed_pc
      counter <= pht[indexed_pc];

      // Predict branch direction
      predict_taken <= (counter[1] == 2);

      // Update predicted history register
      predict_history <= indexed_history;
    end
  end

  // Train
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      pht <= 0;
    end else if (train_valid) begin
      indexed_pc <= train_pc;
      indexed_history <= train_history;

      // Get the counter value from PHT using indexed_pc
      counter <= pht[indexed_pc];

      // Update the counter based on train_taken and train_mispredicted
      if (train_mispredicted) begin
        counter <= (counter == 0) ? 0 : (counter - 1);
      end else if (train_taken) begin
        counter <= (counter == 3) ? 3 : (counter + 1);
      end

      // Update the PHT with the updated counter value
      pht[indexed_pc] <= counter;

      // Update the history register
      updated_history <= (train_mispredicted) ? indexed_history : (indexed_history << 1) | train_taken;
    end
  end

endmodule
