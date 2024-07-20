module top_module (
	input clk,
	input in,
	output logic out
);

    logic xor_output;
    logic flip_flop_output;
    
    xor_gate U1 (.a(in), .b(flip_flop_output), .out(xor_output));
    d_flip_flop U2 (.d(xor_output), .clk(clk), .q(flip_flop_output));
    
endmodule
module xor_gate (
    input a,
    input b,
    output logic out
);
assign out = a ^ b;
endmodule
module d_flip_flop (
	input d,
	input clk,
	output logic q
);
    always @(posedge clk)
        q <= d;
endmodule
