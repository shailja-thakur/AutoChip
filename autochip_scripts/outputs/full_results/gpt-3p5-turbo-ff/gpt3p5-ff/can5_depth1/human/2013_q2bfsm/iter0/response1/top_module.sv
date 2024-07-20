module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 2'b00; // state A
	end else begin
		state <= next_state;
	end
end

always @* begin
	next_state = state;
	f = 1'b0;
	g = 1'b0;

	case (state)
		2'b00: begin // state A
			if (~resetn) begin
				next_state = 2'b00; // stay in state A
			end else begin
				next_state = 2'b01; // goto state B
			end
		end

		2'b01: begin // state B
			f = 1'b1; // set f to 1 for one clock cycle
			next_state = 2'b10; // goto state C
		end

		2'b10: begin // state C
			if (x == 1 && $fell(clk)) begin
				next_state = 2'b11; // goto state D
			end else begin
				next_state = 2'b10; // stay in state C
			end
		end

		2'b11: begin // state D
			if (x == 0 && $fell(clk)) begin
				next_state = 2'b10; // goto state C
			end else begin
				next_state = 2'b11; // stay in state D
				g = 1'b1; // set g to 1
			end
		end
	endcase
end

endmodule
