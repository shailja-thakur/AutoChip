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
  
  reg [6:0] branch_history_register; // Branch history register
  reg [6:0] index; // Index for pattern history table
  reg [1:0] pht [127:0]; // Pattern history table (128 entries, each entry is a 2-bit saturating counter)
  
  reg predict_taken_reg; // Register to store predicted taken value
  reg [6:0] predict_pc_reg; // Register to store predicted pc value
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      branch_history_register <= 0;
      index <= 0;
      pht <= 0;
      
      predict_taken_reg <= 0;
      predict_pc_reg <= 0;
    end else begin
      // Update branch history register for predicted branch
      if (predict_valid) begin
        branch_history_register <= {branch_history_register[5:0], predict_taken_reg};
      end
      
      // Update branch history register for trained branch
      if (train_valid) begin
        branch_history_register <= {branch_history_register[5:0], train_taken};
      end
      
      // Update pattern history table for trained branch
      if (train_valid) begin
        pht[index] <= pht[index] + (train_taken == pht[index][1:0] ? 0 : (train_mispredicted ? -1 : 1));
      end
      
      // Predict branch direction and update predict_taken and predict_pc
      if (predict_valid) begin
        predict_taken_reg <= pht[index][1];
        predict_pc_reg <= predict_pc;
      end
      
      // Update index for pattern history table
      index <= {branch_history_register[6] ^ branch_history_register[5], branch_history_register[4:0]};
    end
  end
  
  // Output prediction values
  assign predict_taken = predict_taken_reg;
  assign predict_history = branch_history_register;
  
endmodule
