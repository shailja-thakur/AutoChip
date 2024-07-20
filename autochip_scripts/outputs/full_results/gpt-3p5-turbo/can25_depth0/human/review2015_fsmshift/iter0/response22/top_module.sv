module top_module(
	input clk,
	input reset,
	output shift_ena);

reg [2:0] state;
reg [3:0] counter;

parameter IDLE = 0;
parameter SHIFT_ENA = 1;

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		counter <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (counter == 4'b1010) begin // replace "4'b1010" with the proper bit pattern
					state <= SHIFT_ENA;
					counter <= 0;
				end else begin
					state <= IDLE;
					counter <= counter + 1;
				end
			end
			SHIFT_ENA: begin
				state <= IDLE;
				counter <= counter + 1;
			end
		endcase
	end
end

assign shift_ena = (state == SHIFT_ENA);

endmodule
