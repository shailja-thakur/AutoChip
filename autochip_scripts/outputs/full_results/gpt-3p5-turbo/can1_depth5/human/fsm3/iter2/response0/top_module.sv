module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] current_state, next_state;
	reg out_reg;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= 2'b00; // Reset to state A
		end else begin
			current_state <= next_state;
		end
	end

	always @(*) begin
		case (current_state)
			2'b00: begin
				if (in) begin
					next_state = 2'b01; // Next state is B
				end else begin
					next_state = 2'b00; // Next state is A
				end
				out_reg = 1'b0; // Output is 0
			end
			2'b01: begin
				if (in) begin
					next_state = 2'b10; // Next state is C
				end else begin
					next_state = 2'b01; // Next state is B
				end
				out_reg = 1'b0; // Output is 0
			end
			2'b10: begin
				if (in) begin
					next_state = 2'b00; // Next state is A
				end else begin
					next_state = 2'b11; // Next state is D
				end
				out_reg = 1'b0; // Output is 0
			end
			2'b11: begin
				if (in) begin
					next_state = 2'b01; // Next state is B
				end else begin
					next_state = 2'b10; // Next state is C
				end
				out_reg = 1'b1; // Output is 1
			end
		endcase
	end

	always @(posedge clk) begin
		out <= out_reg;
	end

endmodule
