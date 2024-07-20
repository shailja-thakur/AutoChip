module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg [3:0] counter;
	parameter IDLE = 3'b000;
	parameter SHIFT = 3'b001;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (input_bit_pattern) begin
						state <= SHIFT;
						counter <= 4;
						shift_ena <= 1;
					end else begin
						shift_ena <= 0;
					end
				end
				
				SHIFT: begin
					if (counter == 1) begin
						state <= IDLE;
						shift_ena <= 0;
					end else begin
						counter <= counter - 1;
					end
				end
			endcase
		end
	end
	
	// Define your input_bit_pattern logic here
	
endmodule
