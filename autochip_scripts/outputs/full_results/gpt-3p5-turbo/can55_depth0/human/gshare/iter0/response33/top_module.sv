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

  reg [6:0] pcreg;
  reg [6:0] historyreg;
  reg [6:0] index;
  reg [1:0] counter;
  reg [1:0] table [0:127];

  // reset logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      pcreg <= 0;
      historyreg <= 0;
    end else begin
      pcreg <= predict_pc;
      historyreg <= train_history;
    end
  end

  // prediction logic
  always @(posedge clk) begin
    if (predict_valid) begin
      index <= pcreg ^ historyreg;
      predict_taken <= counter[1];
      predict_history <= historyreg;
    end
  end
  
  // training logic
  always @(posedge clk) begin
    if (train_valid) begin
      index <= train_pc ^ train_history;
      if (train_mispredicted) begin
        counter <= counter - (counter != 0);
      end else begin
        counter <= counter + (counter != 3);
      end
    end
  end

  // update table
  always @(posedge clk) begin
    if (train_valid) begin
      table[index] <= counter;
    end
  end

endmodule
