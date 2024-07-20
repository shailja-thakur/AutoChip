module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting
	);
	
	// State definitions
	parameter IDLE = 0;
	parameter CHECKING = 1;
	
	// Internal signals
	reg [1:0] state;
	reg [3:0] shift_buffer;
	
	// Sequential logic
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= IDLE;
			start_shifting <= 0;
		end else begin
			case (state)
				IDLE: begin
					shift_buffer <= {shift_buffer[2:0], data};
					if (shift_buffer == 4'b1101)
						state <= CHECKING;
				end
				CHECKING: begin
					shift_buffer <= {shift_buffer[2:0], data};
					start_shifting <= 1;
					if (shift_buffer != 4'b1101)
						state <= IDLE;
				end
			endcase
		end
	end
	
endmodule
