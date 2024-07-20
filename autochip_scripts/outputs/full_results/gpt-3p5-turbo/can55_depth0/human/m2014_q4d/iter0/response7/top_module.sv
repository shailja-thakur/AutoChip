module top_module (
	input clk,
	input in,
	output logic out
);
reg d;
wire d_out;

xor #(2) xor1(.a(in), .b(out), .z(d));

always @(posedge clk) begin
    d <= d_out;
end

dff #(1) flip_flop1(.d(d), .clk(clk), .q(out));

assign d_out = xor1.z;

endmodule
