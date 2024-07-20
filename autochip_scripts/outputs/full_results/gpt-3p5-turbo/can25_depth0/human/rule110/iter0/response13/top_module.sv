module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  // Wire declarations
  wire [511:0] next_state;

  // Rule 110
  assign next_state[0] = (q[1] & q[0]) | (~q[1] & q[0]);
  assign next_state[511] = (q[510] & q[511]) | (~q[510] & q[511]);
  generate
    genvar i;
    for (i = 1; i < 511; i++) begin : rule110
      assign next_state[i] = (q[i-1] & q[i] & ~q[i+1]) | (q[i-1] & ~q[i] & q[i+1]) | (q[i-1] & ~q[i] & ~q[i+1]) | (~q[i-1] & q[i] & q[i+1]);
    end
  endgenerate

  // State update process
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= next_state;
    end
  end

endmodule
