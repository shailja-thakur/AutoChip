module top_module(
	input clk,
	input reset,
	output reg shift_ena);
				
	reg [3:0] state;
	reg [3:0] next_state;

	parameter IDLE = 4'b0000;
	parameter DETECTED = 4'b0001;
	parameter ENABLED = 4'b0010;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			shift_ena <= 1'b0;
		end else begin
			state <= next_state;
			shift_ena <= (state == ENABLED) ? 1'b1 : 1'b0;
		end
	end

	always @(state) begin
		case (state)
			IDLE: begin
				if (/* condition for bit pattern detection */) begin
					next_state = DETECTED;
				end else begin
					next_state = IDLE;
				end
			end
			DETECTED: begin
				next_state = ENABLED;
			end
			ENABLED: begin
				next_state = IDLE;
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end
endmodule
