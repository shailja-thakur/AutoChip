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

  reg [6:0] branch_history;
  reg [6:0] predict_index;
  reg [1:0] predict_state;
  reg [6:0] train_index;
  
  reg [6:0] pht [0:127];
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      branch_history <= 0;
      predict_index <= 0;
      predict_state <= 0;
      train_index <= 0;
      for (int i = 0; i < 128; i = i + 1) begin
        pht[i] <= 0;
      end
    end else begin
      if (predict_valid) begin
        predict_index <= predict_pc ^ branch_history;
        predict_taken <= pht[predict_index][predict_state];
        predict_history <= branch_history;
      end
        
      if (train_valid) begin
        train_index <= train_pc ^ train_history;
        if (train_taken) begin
          if (train_mispredicted) begin
            branch_history <= train_history;
          end
          pht[train_index][predict_state] <= pht[train_index][predict_state] + 1;
          if (pht[train_index][predict_state] > 3) begin
            pht[train_index][predict_state] <= 3;
          end
        else begin
          if (!train_mispredicted) begin
            branch_history <= train_history;
          end
          pht[train_index][predict_state] <= pht[train_index][predict_state] - 1;
          if (pht[train_index][predict_state] < 0) begin
            pht[train_index][predict_state] <= 0;
          end
        end
      end
    end
  end
endmodule
