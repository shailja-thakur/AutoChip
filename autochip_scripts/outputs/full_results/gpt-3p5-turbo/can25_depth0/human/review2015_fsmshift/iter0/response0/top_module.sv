module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg [1:0] count;

	parameter IDLE = 0;
	parameter COUNT = 1;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
			shift_ena <= 1;
		end else begin
			case (state)
				IDLE: begin
					count <= 0;
					shift_ena <= 0;
					if (pattern_detected) begin
						state <= COUNT;
					end
				end
				COUNT: begin
					if (count == 3) begin
						state <= IDLE;
					end else begin
						count <= count + 1;
						shift_ena <= 1;
					end
				end
			endcase
		end
	end

	function pattern_detected;
		input [7:0] data;
		begin
			pattern_detected = (data == 8'b01100100);
		end
	endfunction

endmodule
