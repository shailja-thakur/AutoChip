module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	always @ (state, in)
	begin
		case (state)
			4'b0001: if (in == 1'b0) begin next_state = 4'b0001; out = 1'b0; end
				else if (in == 1'b1) begin next_state = 4'b0010; out = 1'b0; end
			4'b0010: if (in == 1'b0) begin next_state = 4'b0100; out = 1'b0; end
				else if (in == 1'b1) begin next_state = 4'b0010; out = 1'b0; end
			4'b0100: if (in == 1'b0) begin next_state = 4'b0001; out = 1'b0; end
				else if (in == 1'b1) begin next_state = 4'b1000; out = 1'b0; end
			4'b1000: if (in == 1'b0) begin next_state = 4'b0100; out = 1'b1; end
				else if (in == 1'b1) begin next_state = 4'b0010; out = 1'b0; end
			default: begin next_state = 4'bxxxx; out = 1'bx; end
		endcase
	end

endmodule
