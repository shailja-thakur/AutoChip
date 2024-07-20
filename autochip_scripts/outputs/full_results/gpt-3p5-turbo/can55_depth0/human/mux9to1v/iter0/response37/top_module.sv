module top_module (
	input [15:0] a,
	input [15:0] b,
	input [15:0] c,
	input [15:0] d,
	input [15:0] e,
	input [15:0] f,
	input [15:0] g,
	input [15:0] h,
	input [15:0] i,
	input [3:0] sel,
	output logic [15:0] out
);

always_comb begin
	case(sel)
		4'd0: out = a;
		4'd1: out = b;
		4'd2: out = c;
		4'd3: out = d;
		4'd4: out = e;
		4'd5: out = f;
		4'd6: out = g;
		4'd7: out = h;
		4'd8: out = i;
		4'd9, 4'd10, 4'd11, 4'd12, 4'd13, 4'd14, 4'd15: out = 16'b1;
		endcase
end

endmodule
