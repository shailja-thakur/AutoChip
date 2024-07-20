module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// Declare state register and next state signal
	reg [1:0] state;
	reg [1:0] next_state;

	// Define states
	parameter OFF = 2'b00;
	parameter ON = 2'b01;

	// Synchronous reset to OFF state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end

	// Combinational logic to compute next state and output
	always @* begin
		case (state)
			OFF: begin
				if (j) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
				out = 0;
			end
			ON: begin
				if (k) begin
					next_state = OFF;
				end else begin
					next_state = ON;
				end
				out = 1;
			end
			default: begin
				next_state = OFF;
				out = 0;
			end
		endcase
	end

endmodule
