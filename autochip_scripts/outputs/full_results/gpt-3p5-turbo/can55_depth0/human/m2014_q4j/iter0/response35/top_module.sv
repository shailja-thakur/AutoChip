module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] xor1;
wire [3:0] xor2;

genvar i;
generate
  generate
    for (i = 0; i < 4; i = i + 1) begin: full_adder
      assign xor1[i] = x[i] ^ y[i];
      assign xor2[i] = xor1[i] ^ carry[i];
      assign carry[i+1] = (x[i] & y[i]) | (xor1[i] & carry[i]);
    end
  endgenerate
endgenerate

assign sum[0] = xor2[0];
assign sum[1] = xor2[1];
assign sum[2] = xor2[2];
assign sum[3] = xor2[3];
assign sum[4] = carry[4];

endmodule
