module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

  // Define the state register to store the global history shift register
  reg [31:0] state;

  // Define the temporary registers to store the updated history and mispredicted history
  reg [31:0] updated_history;
  reg [31:0] mispredicted_history;

  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= 0;
    else if (train_mispredicted)
      state <= mispredicted_history;
    else if (predict_valid)
    begin
      updated_history[31:1] <= predict_history[30:0];
      updated_history[0] <= predict_taken;
      state <= updated_history;
    end
  end

  always @(posedge clk or posedge areset)
  begin
    if (areset)
      mispredicted_history <= 0;
    else if (train_mispredicted)
    begin
      mispredicted_history[31:1] <= train_history[30:0];
      mispredicted_history[0] <= train_taken;
    end
  end

  assign predict_history = state;

endmodule
