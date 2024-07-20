module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
	reg mux_in0, mux_in1, mux_in2, mux_in3;

	assign mux_in[0] = mux_in0;
	assign mux_in[1] = mux_in1;
	assign mux_in[2] = mux_in2;
	assign mux_in[3] = mux_in3;

	always @ (c, d)
	begin
		case ({c, d})
			2'b00:
				begin
					mux_in0 <= 1'b0;
					mux_in1 <= 1'b0;
					mux_in2 <= 1'b0;
					mux_in3 <= 1'b1;
				end
			2'b01:
				begin
					mux_in0 <= 1'b1;
					mux_in1 <= 1'b0;
					mux_in2 <= 1'b0;
					mux_in3 <= 1'b0;
				end
			2'b11:
				begin
					mux_in0 <= 1'b1;
					mux_in1 <= 1'b0;
					mux_in2 <= 1'b1;
					mux_in3 <= 1'b1;
				end
			2'b10:
				begin
					mux_in0 <= 1'b1;
					mux_in1 <= 1'b0;
					mux_in2 <= 1'b0;
					mux_in3 <= 1'b1;
				end
			default:
				begin
					mux_in0 <= 1'b0;
					mux_in1 <= 1'b0;
					mux_in2 <= 1'b0;
					mux_in3 <= 1'b0;
				end
		endcase
	end
endmodule
