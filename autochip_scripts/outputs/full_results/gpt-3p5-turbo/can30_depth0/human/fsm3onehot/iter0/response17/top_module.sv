module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// State transition logic
	always @(state, in) begin
		case(state)
			4'b0001: if (in == 1'b0) next_state = 4'b0001; else next_state = 4'b0010;
			4'b0010: if (in == 1'b0) next_state = 4'b0100; else next_state = 4'b0010;
			4'b0100: if (in == 1'b0) next_state = 4'b0001; else next_state = 4'b1000;
			4'b1000: if (in == 1'b0) next_state = 4'b0100; else next_state = 4'b0010;
			default: next_state = 4'bxxxx;
		endcase
	end

	// Output logic
	always @(state) begin
		case(state)
			4'b0001: out = 1'b0;
			4'b0010: out = 1'b0;
			4'b0100: out = 1'b0;
			4'b1000: out = 1'b1;
			default: out = 1'bx;
		endcase
	end
	
endmodule
