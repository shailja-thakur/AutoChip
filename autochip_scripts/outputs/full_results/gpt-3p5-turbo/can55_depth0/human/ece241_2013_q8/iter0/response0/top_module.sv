module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// Define state enumeration
	typedef enum logic [1:0] {
		S0,
		S1,
		S2
	} state_t;

	// Define state and next state variables
	reg state_t state, next_state;

	// Define register for sequence detection
	reg [1:0] shift_reg;

	// Define constants for sequence detection
	parameter [1:0] SEQ_101 = 2'b10;

	// Synchronous process with positive edge of the clock
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S0;
			shift_reg <= 2'b00;
		end else begin
			state <= next_state;
			shift_reg <= {shift_reg[0], x};
		end
	end

	// Combinational process for next state and output logic
	always @* begin
		case (state)
			S0: begin
				if (shift_reg == SEQ_101) begin
					next_state = S1;
					z = 1'b1;
				end else begin
					next_state = S0;
					z = 1'b0;
				end
			end
			S1: begin
				if (shift_reg == SEQ_101) begin
					next_state = S2;
					z = 1'b1;
				end else begin
					next_state = S0;
					z = 1'b0;
				end
			end
			S2: begin
				if (shift_reg == SEQ_101) begin
					next_state = S1;
					z = 1'b1;
				end else begin
					next_state = S0;
					z = 1'b0;
				end
			end
		endcase
	end
endmodule
