module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] xor_out;
wire [3:0] and_out;

genvar i;
generate
for(i=0; i<4; i=i+1) begin
    full_adder FA(x[i], y[i], carry[i], sum[i], carry[i+1]);
end
endgenerate

assign carry[0] = 1'b0;

genvar j;
generate
for(j=0; j<4; j=j+1) begin
    xor_gate XOR(sum[j], x[j], y[j]);
end
endgenerate

endmodule
module full_adder (
	input a,
	input b,
	input c,
	output s,
	output cout
);
	xor_gate xor1(.a(a), .b(b), .out(xor_out))
	xor_gate xor2(.a(xor_out), .b(c), .out(s))
	and_gate and1(.a(a), .b(b), .out(and_out))
	and_gate and2(.a(and_out), .b(c), .out(cout))
endmodule
module xor_gate (
	input a,
	input b,
	output out
);
	assign out = a ^ b;
endmodule
module and_gate (
	input a,
	input b,
	output out
);
	assign out = a & b;
endmodule
