module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b10;	// reset to state B
		end else begin
			state <= next_state;	// update state
		end
	end

	always @* begin
		case (state)
			2'b00: begin	// State A
				if (in) begin
					next_state = 2'b00;	// Next state is A
				end else begin
					next_state = 2'b01;	// Next state is B
				end
			end
			2'b01: begin	// State B
				if (in) begin
					next_state = 2'b01;	// Next state is B
				end else begin
					next_state = 2'b00;	// Next state is A
				end
			end
			default: next_state = 2'b??;	// Unknown state
		endcase
	end

	assign out = (state == 2'b01);

endmodule
