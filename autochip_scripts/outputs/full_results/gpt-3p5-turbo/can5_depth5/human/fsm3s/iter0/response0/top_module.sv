module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	reg [1:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else
			state <= next_state;
	end

	always @(state, in) begin
		case (state)
			2'b00: begin
				if (in)
					next_state = 2'b01;
				else
					next_state = 2'b10;
				out <= 1'b0;
			end
			
			2'b01: begin
				if (in)
					next_state = 2'b11;
				else
					next_state = 2'b01;
				out <= 1'b0;
			end
			
			2'b10: begin
				if (in)
					next_state = 2'b00;
				else
					next_state = 2'b10;
				out <= 1'b0;
			end

			2'b11: begin
				if (in)
					next_state = 2'b10;
				else
					next_state = 2'b01;
				out <= 1'b1;
			end

			default: begin
				next_state = 2'b00;
				out <= 1'b0;
			end
		endcase
	end
	
endmodule
