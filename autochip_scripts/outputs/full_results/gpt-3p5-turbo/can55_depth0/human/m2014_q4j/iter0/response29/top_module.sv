module top_module (
  input [3:0] x,
  input [3:0] y,
  output reg [4:0] sum
);

  wire [3:0] carry;  // intermediate carry bits
  
  // Full Adder
  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : full_adder_gen
      full_adder full_adder_inst (
        .a(x[i]),
        .b(y[i]),
        .cin(carry[i]),
        .sum(sum[i]),
        .cout(carry[i+1])
      );
    end
  endgenerate

  assign sum[4] = carry[4];
  
endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  wire c1, c2;
  
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (cin & (a ^ b));
endmodule
