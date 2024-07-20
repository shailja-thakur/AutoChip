module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  wire [3:0] carry;
  wire [3:0] sum_temp;

  genvar i;
  generate
    for (i = 0; i < 4; i=i+1) begin : full_adder_block
      full_adder FA(
        .a(x[i]),
        .b(y[i]),
        .cin(carry[i]),
        .sum(sum_temp[i]),
        .cout(carry[i+1])
      );
    end
  endgenerate

  assign sum[0] = carry[0];
  assign sum[1:4] = sum_temp;

endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);

  assign {cout,sum} = a + b + cin;

endmodule
