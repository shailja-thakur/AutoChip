module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  // Declare internal wires
  wire [511:0] q_temp;

  // Rule 110
  assign q_temp[0] = (q[1] & q[0]) | (~q[1] & ~q[0]);
  assign q_temp[511] = (~q[511] & ~q[510]) | (~q[511] & q[510]) | (q[511] & ~q[510]);
  genvar i;
  generate
    for (i = 1; i < 511; i = i + 1) begin : RULE110
      assign q_temp[i] = (~q[i] & q[i-1] & q[i+1]) | 
                        (~q[i] & q[i-1] & ~q[i+1]) | 
                        (~q[i] & ~q[i-1] & q[i+1]) | 
                        (q[i] & ~q[i-1] & ~q[i+1]);
    end
  endgenerate

  // Load input data
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= q_temp;
    end
  end

endmodule
