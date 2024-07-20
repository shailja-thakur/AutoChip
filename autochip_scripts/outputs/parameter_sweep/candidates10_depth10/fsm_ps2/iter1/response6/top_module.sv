module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done // Use 'reg' instead of 'output done'
);

	// Registers for FSM state and current byte count
	reg [1:0] state;
	reg [2:0] count;
	reg [7:0] in_reg; // Create a register for input

	// Constants for FSM states
	localparam IDLE = 2'b00;
	localparam SEARCH = 2'b01;
	localparam DONE = 2'b10;

	// FSM logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
			in_reg <= 0; // Reset input register
		end else begin
			in_reg <= in; // Store input in the register

			case (state)
				IDLE: begin
					state <= (in_reg[3] == 1'b1) ? SEARCH : IDLE;
					count <= 0;
				end
				SEARCH: begin
					state <= (count == 2) ? DONE : SEARCH;
					count <= (in_reg[3] == 1'b1) ? 1 : 0;
				end
				DONE: begin
					state <= IDLE;
					count <= 0;
				end
			endcase
		end
	end

	// Output assignment
	assign done = (state == DONE);
endmodule
