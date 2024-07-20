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

  // Declare registers and wires
  reg [6:0] pc;
  reg [6:0] history;
  reg predict_taken;
  wire [6:0] index;
  reg [1:0] counter;
  reg [6:0] pht_value;
  wire pht_write_enable;
  reg training_requested;

  // Hash pc and history into index
  assign index = predict_pc ^ history;

  // Determine taken branch prediction and output history
  assign {predict_taken, predict_history} = pht[index];

  // Update history register and pattern history table (PHT)
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      pc <= 0;
      history <= 0;
      pht_value <= 0;
    end else begin
      pc <= predict_pc;
      history <= train_history;
      pht_value <= pht_value + (training_requested & (train_mispredicted | train_taken));
    end
  end

  // Determine if a training request is made
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      training_requested <= 0;
    end else begin
      training_requested <= train_valid;
    end
  end

  // Determine if PHT entry needs to be updated
  assign pht_write_enable = predict_valid | (training_requested & train_mispredicted);

  // Update PHT if necessary
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      counter <= 0;
    end else begin
      if (pht_write_enable) begin
        case(counter)
          0: pht[index] <= 2'b01;
          1: pht[index] <= 2'b10;
          2: pht[index] <= 2'b11;
          3: pht[index] <= 2'b11;
        endcase
      end
    end
  end
endmodule
