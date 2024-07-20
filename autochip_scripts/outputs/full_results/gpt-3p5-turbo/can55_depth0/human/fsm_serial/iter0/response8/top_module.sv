module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	
	reg [2:0] state;
	reg start_bit;
	reg [7:0] data_bits;
	reg stop_bit;
	
	parameter IDLE = 0;
	parameter START = 1;
	parameter DATA = 2;
	parameter STOP = 3;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else begin
			case (state)
				IDLE: begin
					if (in == 0)
						state <= START;
				end
				START: begin
					start_bit <= in;
					state <= DATA;
				end
				DATA: begin
					data_bits <= {data_bits[6:0], in};
					
					if (data_bits == 8'b11111111)
						state <= STOP;
				end
				STOP: begin
					stop_bit <= in;
					
					if (stop_bit)
						state <= IDLE;
				end
			endcase
		end
	end
	
	assign done = (state == IDLE);
	
endmodule
