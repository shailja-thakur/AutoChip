module top_module(
	input clk,
	input reset,
	output reg shift_ena);
	
	reg [2:0] state;
	
	parameter IDLE = 0;
	parameter DETECT = 1;

	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1;
			state <= IDLE;
		end else begin
			case (state)
				IDLE: begin
					shift_ena <= 1;
					if (/*add condition*/) begin
						state <= DETECT;
					end
				end
				DETECT: begin
					if (/*add condition*/) begin
						state <= IDLE;
					end
				end
			endcase
		end
	end

endmodule
