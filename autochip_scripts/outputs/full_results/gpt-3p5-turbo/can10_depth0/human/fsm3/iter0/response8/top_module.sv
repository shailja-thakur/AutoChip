module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset state to A
		end else begin
			state <= next_state;
		end
	end
	
	always @(state, in) begin
		case (state)
			2'b00: begin // State A
				if (in) begin
					next_state <= 2'b01; // Next state B
					out <= 1'b0;
				end else begin
					next_state <= 2'b00; // Next state A
					out <= 1'b0;
				end
			end
			2'b01: begin // State B
				if (in) begin
					next_state <= 2'b01; // Next state B
					out <= 1'b0;
				end else begin
					next_state <= 2'b10; // Next state C
					out <= 1'b0;
				end
			end
			2'b10: begin // State C
				if (in) begin
					next_state <= 2'b11; // Next state D
					out <= 1'b0;
				end else begin
					next_state <= 2'b00; // Next state A
					out <= 1'b0;
				end
			end
			2'b11: begin // State D
				if (in) begin
					next_state <= 2'b10; // Next state C
					out <= 1'b1;
				end else begin
					next_state <= 2'b01; // Next state B
					out <= 1'b1;
				end
			end
		endcase
	end
endmodule
