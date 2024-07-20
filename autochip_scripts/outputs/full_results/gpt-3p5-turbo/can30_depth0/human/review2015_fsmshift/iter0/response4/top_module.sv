module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	// Internal signals
	reg [1:0] state;

	// FSM states
	parameter IDLE = 2'b00;
	parameter ENABLE = 2'b01;
	parameter RESET = 2'b10;

	// FSM transition logic
	always @(posedge clk or negedge reset) begin
		if (reset)
			state <= RESET;
		else begin
			case (state)
				IDLE: begin
					if (/* add your condition for detecting the proper bit pattern*/)
						state <= ENABLE;
					else
						state <= IDLE;
				end
				ENABLE: state <= RESET;
				RESET: state <= IDLE;
			endcase
		end
	end

	// Output logic
	always @(posedge clk or negedge reset) begin
		if (reset)
			shift_ena <= 1'b1; // Assert shift enable for 4 cycles during reset
		else begin
			case (state)
				IDLE: shift_ena <= 1'b0;
				ENABLE: shift_ena <= 1'b1;
				RESET: shift_ena <= 1'b0;
			endcase
		end
	end
endmodule
