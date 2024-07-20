module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	
	reg [2:0] state;
	reg [7:0] data;
	reg done;
	
	parameter IDLE = 0;
	parameter START_BIT = 1;
	parameter DATA_BITS = 2;
	parameter STOP_BIT = 3;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data <= 0;
			done <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (in == 0)
						state <= START_BIT;
				end
				
				START_BIT: begin
					state <= DATA_BITS;
				end
				
				DATA_BITS: begin
					data <= {data[6:0], in};
					if (data == 8'hFF)
						state <= STOP_BIT;
				end
				
				STOP_BIT: begin
					if (in == 1) begin
						state <= IDLE;
						done <= 1;
					end
				end
			endcase
		end
	end
endmodule
