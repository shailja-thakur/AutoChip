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

  reg [1:0] pht [0:127];
  reg [6:0] bhr;
  reg predict_taken_reg;
  reg [6:0] predict_history_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // reset branch history register and pattern history table
      bhr <= 7'b0;
      for (integer i = 0; i < 128; i = i + 1) begin
        pht[i] <= 2'b00;
      end
    end else begin
      // prediction
      if (predict_valid) begin
        predict_history_reg <= bhr;
        predict_taken_reg <= pht[predict_pc ^ bhr];
      end
      
      // training
      if (train_valid) begin
        if (train_mispredicted) begin
          bhr <= (train_history ^ train_pc) << 1;
        end
        pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + (train_taken ? 1 : -1);
      end
    end
  end
  
  assign predict_taken = predict_taken_reg;
  assign predict_history = predict_history_reg;

endmodule
