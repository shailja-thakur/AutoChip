module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg [2:0] next_state;
	assign disc = (state == 3'b100);
	assign flag = (state == 3'b101);
	assign err = (state == 3'b110);

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	always @(state, in) begin
		case (state)
			3'b000: if (in) next_state = 3'b001; else next_state = 3'b000;
			3'b001: if (in) next_state = 3'b010; else next_state = 3'b000;
			3'b010: if (in) next_state = 3'b011; else next_state = 3'b000;
			3'b011: if (in) next_state = 3'b100; else next_state = 3'b000;
			3'b100: if (in) next_state = 3'b101; else next_state = 3'b000;
			3'b101: if (in) next_state = 3'b110; else next_state = 3'b000;
			3'b110: next_state = 3'b000;
			default: next_state = 3'b000;
		endcase
	end
endmodule
