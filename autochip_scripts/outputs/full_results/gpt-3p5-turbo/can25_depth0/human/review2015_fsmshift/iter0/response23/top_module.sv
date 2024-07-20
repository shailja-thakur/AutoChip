module top_module(
	input clk,
	input reset,
	output shift_ena);
	
reg [2:0] state;
reg [3:0] count;

parameter IDLE = 0;
parameter DETECT_PATTERN = 1;
parameter SHIFT_ENABLE = 2;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		count <= 0;
	end else begin
		case(state)
			IDLE: begin
				if (/*condition for detecting pattern*/) begin
					state <= DETECT_PATTERN;
				end
			end
			
			DETECT_PATTERN: begin
				if (count < 3) begin
					count <= count + 1;
				end else begin
					state <= SHIFT_ENABLE;
					count <= 0;
				end
			end
			
			SHIFT_ENABLE: begin
				if (count < 3) begin
					count <= count + 1;
				end else begin
					state <= IDLE;
					count <= 0;
				end
			end
		endcase
	end
end

assign shift_ena = (state == SHIFT_ENABLE) ? 1 : 0;

endmodule
