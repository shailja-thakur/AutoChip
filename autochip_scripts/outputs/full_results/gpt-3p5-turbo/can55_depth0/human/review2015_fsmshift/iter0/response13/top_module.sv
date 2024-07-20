module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] state;

	parameter IDLE = 2'b00;
	parameter DETECT = 2'b01;
	
	// FSM process
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			shift_ena <= 1'b0;
		end
		else begin
			case (state)
				IDLE: begin
					if (/* check for bit pattern */) begin
						state <= DETECT;
						shift_ena <= 1'b1;
					end
				end
				
				DETECT: begin
					if (/* check if 4 cycles have passed */) begin
						state <= IDLE;
						shift_ena <= 1'b0;
					end
				end
			endcase
		end
	end
endmodule
