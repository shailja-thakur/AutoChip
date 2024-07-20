module top_module (
	input clk,
	input j,
	input k,
	input rst,
	output reg out
);

	// Define the state enum
	typedef enum logic [1:0] {
		OFF,
		ON
	} state_t;

	reg state_reg, next_state_reg;

	// Output logic
	always @(posedge clk) begin
		if (rst) begin
			state_reg <= OFF;
			out <= 0;
		end else begin
			state_reg <= next_state_reg;
			case (state_reg)
				OFF: out <= 0;
				ON: out <= 1;
			endcase
		end
	end

	// State transition logic
	always @(posedge clk) begin
		if (rst) begin
			next_state_reg <= OFF;
		end else begin
			case (state_reg)
				OFF: if (j) next_state_reg <= ON; else next_state_reg <= OFF;
				ON: if (k) next_state_reg <= OFF; else next_state_reg <= ON;
			endcase
		end
	end
endmodule
