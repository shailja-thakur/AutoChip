module top_module (
	input clk,
	input in,
	output logic out
);

logic d_ff_out;
logic xor_out;
logic d_ff_in;

D_FF dff (clk, d_ff_in, d_ff_out);
XOR2 xor_gate (in, d_ff_out, xor_out);

always @(posedge clk)
begin
	d_ff_in <= xor_out;
	out <= d_ff_out;
end

endmodule
module D_FF (
	input clk,
	input logic d,
	output logic q
);
	always @(posedge clk)
	begin
		q <= d;
	end
endmodule
module XOR2 (
	input a,
	input b,
	output logic y
);
	assign y = a ^ b;
endmodule
