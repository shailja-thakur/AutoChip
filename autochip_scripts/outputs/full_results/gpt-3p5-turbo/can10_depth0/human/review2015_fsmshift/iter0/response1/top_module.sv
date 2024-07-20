module top_module(
	input wire clk,
	input wire reset,
	output wire shift_ena);

	reg [2:0] count;

	// FSM states
	parameter IDLE = 2'b00;
	parameter DETECT_PATTERN = 2'b01;
	parameter ENABLE_SHIFT = 2'b10;
	
	reg [1:0] state;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else begin
			case (state)
				IDLE:
					if (/* condition to detect pattern */)
						state <= DETECT_PATTERN;
					else
						state <= IDLE;
				DETECT_PATTERN:
					state <= ENABLE_SHIFT;
				ENABLE_SHIFT:
					state <= IDLE;
			endcase
		end
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			shift_ena <= 1'b0;
		else begin
			case (state)
				IDLE:
					shift_ena <= 1'b0;
				DETECT_PATTERN:
					shift_ena <= 1'b1;
				ENABLE_SHIFT:
					shift_ena <= 1'b0;
			endcase
		end
	end
endmodule
