module top_module(
  input clk,
  input reset,
  output reg [4:0] q);
  
  reg [4:0] state;

  always @(posedge clk) begin
    if (reset)
      state <= 5'b1;
    else
      state <= {state[3] ^ state[4], state[0:3]};
  end

  assign q = state;

endmodule
