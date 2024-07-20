module top_module (
	input [7:0] in,
	output [31:0] out
);

    // Sign extend the 8-bit input 'in' to 32-bit using the replication operator
    assign out = {{24{in[7]}}, in};

endmodule
