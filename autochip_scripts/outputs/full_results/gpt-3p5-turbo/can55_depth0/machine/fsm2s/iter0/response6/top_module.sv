module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  reg [1:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00; // Initialize to state A
    else if (state == 2'b00) begin // State A
      if (j)
        state <= 2'b01; // Next state B when j is high
    end else begin // State B
      if (k)
        state <= 2'b00; // Next state A when k is high
    end
  end

  assign out = (state == 2'b01); // Output is high when state is B

endmodule
