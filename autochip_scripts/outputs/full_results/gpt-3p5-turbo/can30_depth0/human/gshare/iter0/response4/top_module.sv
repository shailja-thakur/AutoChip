module top_module(
  input clk,
  input areset,
  
  input predict_valid,
  input [6:0] predict_pc,
  output predict_taken,
  output reg [6:0] predict_history,
  
  input train_valid,
  input train_taken,
  input train_mispredicted,
  input [6:0] train_history,
  input [6:0] train_pc
);

  reg predict_taken;
  reg [6:0] predict_history;
  
  reg [6:0] pc_hashed;
  reg [6:0] index;
  reg [127:0] pattern_history_table;
  reg [1:0] counter;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      predict_taken <= 1'b0;
      predict_history <= 7'b0;
      pc_hashed <= 7'b0;
      index <= 7'b0;
      pattern_history_table <= 128'b0;
      counter <= 2'b0;
    end
    else begin
      if (predict_valid) begin
        predict_history <= predict_pc;
        pc_hashed <= predict_pc ^ predict_history;
        index <= pc_hashed;
        predict_taken <= (pattern_history_table[index] == 2'b11 || pattern_history_table[index] == 2'b10);
      end
      
      if (train_valid) begin
        pc_hashed <= train_pc ^ train_history;
        index <= pc_hashed;
        
        if (train_mispredicted) begin
          pattern_history_table[index] <= pattern_history_table[index] - (pattern_history_table[index] > 2'b00); // Decrement counter
          
          // Recover branch history register
          predict_history <= train_history;
        end
        else begin
          pattern_history_table[index] <= pattern_history_table[index] + (pattern_history_table[index] < 2'b11); // Increment counter
        end
      end
    end
  end
endmodule
