module top_module(
	input clk,
	input reset,
	output shift_ena);
		
	reg [1:0] state;
	reg [3:0] counter;
		
	parameter IDLE = 2'b00;
	parameter DETECTING = 2'b01;
			
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			shift_ena <= 0;
			counter <= 0;
		end else begin
			case (state)
				IDLE:
					if (/* condition for pattern detection */) begin
						state <= DETECTING;
						shift_ena <= 1;
						counter <= 4;
					end
				DETECTING:
					if (counter == 4) begin
						state <= IDLE;
						shift_ena <= 0;
					end else begin
						counter <= counter + 1;
					end
			endcase
		end
	end
		
endmodule
