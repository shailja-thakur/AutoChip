module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  // Instantiate the full adders
  wire [3:0] carry;
  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : ADDER_LOOP
      full_adder fa(
        .x(x[i]),
        .y(y[i]),
        .cin(carry[i]),
        .sum(sum[i]),
        .cout(carry[i+1])
      );
    end
  endgenerate
  
  assign sum[4] = carry[4];

endmodule
module full_adder (
  input x,
  input y,
  input cin,
  output sum,
  output cout
);

  wire w1, w2, w3;

  assign sum = x ^ y ^ cin;
  assign cout = (x & y) | (x & cin) | (y & cin);

endmodule
