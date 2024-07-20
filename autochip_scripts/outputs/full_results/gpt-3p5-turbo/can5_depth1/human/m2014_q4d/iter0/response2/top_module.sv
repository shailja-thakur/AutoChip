module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_out;
logic flip_flop_out;

xor2 gate (.a(in), .b(out), .z(xor_out));
d_flip_flop dff (.clk(clk), .d(xor_out), .q(flip_flop_out));

assign out = flip_flop_out;

endmodule
module xor2 (
    input a,
    input b,
    output z
);
    assign z = a ^ b;
endmodule
module d_flip_flop (
    input clk,
    input d,
    output logic q
);
    always_ff @(posedge clk)
        q <= d;
endmodule
