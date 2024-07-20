module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	reg [1:0] state, next_state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else
			state <= next_state;
	end

	always @(state or w) begin
		case (state)
			2'b00: begin
				if (w)
					next_state = 2'b00;
				else
					next_state = 2'b01;
			end
			2'b01: begin
				if (w)
					next_state = 2'b11;
				else
					next_state = 2'b10;
			end
			2'b10: begin
				if (w)
					next_state = 2'b10;
				else
					next_state = 2'b11;
			end
			2'b11: begin
				if (w)
					next_state = 2'b11;
				else
					next_state = 2'b00;
			end
		endcase
	end

	assign z = (state == 2'b11);

endmodule
