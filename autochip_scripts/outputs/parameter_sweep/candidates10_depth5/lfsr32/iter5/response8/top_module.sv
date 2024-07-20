module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;
  wire [31:0] taps;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      next_q = {q[30:0], q[0] ^ taps[20] ^ taps[0] ^ taps[31]};
      q <= next_q;
    end
  end
  
  assign taps = {q[31], q[21], q[1], q[0]}; // Define taps at bit positions 32, 22, 2, and 1
  
endmodule
