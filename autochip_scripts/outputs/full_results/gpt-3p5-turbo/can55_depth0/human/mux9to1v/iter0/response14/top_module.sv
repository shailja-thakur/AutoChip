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
			4'd0: out = a;   // sel=0 chooses a
			4'd1: out = b;   // sel=1 chooses b
			4'd2: out = c;   // sel=2 chooses c
			4'd3: out = d;   // sel=3 chooses d
			4'd4: out = e;   // sel=4 chooses e
			4'd5: out = f;   // sel=5 chooses f
			4'd6: out = g;   // sel=6 chooses g
			4'd7: out = h;   // sel=7 chooses h
			4'd8: out = i;   // sel=8 chooses i
			default: out = 16'b1111_1111_1111_1111;   // For the unused cases (sel=9 to 15), set all output bits to '1'
		endcase
	end

endmodule
