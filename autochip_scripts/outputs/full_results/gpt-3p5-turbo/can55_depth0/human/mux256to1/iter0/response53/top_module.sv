module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

// Creating a 256-to-1 multiplexer using a case statement
always @(*) begin
	case (sel)
		0: out = in[0];
		1: out = in[1];
		2: out = in[2];
		3: out = in[3];
		4: out = in[4];
		5: out = in[5];
		6: out = in[6];
		7: out = in[7];
		default: out = 1'b0; // default case
	endcase
end

endmodule
