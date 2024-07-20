module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	// Registers for FSM state and current byte count
	reg [1:0] state;
	reg [2:0] count;
	reg prev_in3;

	// Constants for FSM states
	localparam IDLE = 2'b00;
	localparam SEARCH = 2'b01;
	localparam DONE = 2'b10;

	// FSM logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
			done <= 0;
			prev_in3 <= 0;
		end else begin
			case (state)
				IDLE: begin
					state <= (in[3] == 1'b1 && prev_in3 == 1'b0) ? SEARCH : IDLE;
					count <= 0;
					prev_in3 <= in[3];
				end
				SEARCH: begin
					state <= (count == 2) ? DONE : SEARCH;
					count <= count + 1;
					prev_in3 <= in[3];
				end
				DONE: begin
					state <= IDLE;
					count <= 0;
					done <= 1;
					prev_in3 <= in[3];
				end
			endcase
		end
	end

endmodule
