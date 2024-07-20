module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  // Internal signals
  reg [31:0] feedback;
  
  // Feedback taps
  assign feedback[0] = q[31] ^ q[21] ^ q[1] ^ q[0];

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 32'h1;
    else
      q <= {q[30:0], feedback};
  end

endmodule
