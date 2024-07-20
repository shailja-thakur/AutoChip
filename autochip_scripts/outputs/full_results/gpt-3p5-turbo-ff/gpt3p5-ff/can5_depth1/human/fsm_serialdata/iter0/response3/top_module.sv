module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	parameter IDLE = 3'b000;
	parameter START = 3'b001;
	parameter RECEIVE = 3'b010;
	parameter STOP = 3'b011;
	
	reg [2:0] state;
	reg [7:0] data_byte;
	reg done;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data_byte <= 8'b0;
			done <= 1'b0;
		end else begin
			case(state)
				IDLE: begin
					if (in == 1'b0) begin
						state <= START;
						data_byte <= 8'b0;
						done <= 1'b0;
					end
				end
				
				START: begin
					if (in == 1'b0) begin
						state <= RECEIVE;
					end else begin
						state <= IDLE;
					end
				end
				
				RECEIVE: begin
					if (in == 1'b1) begin
						if (data_byte == 8'd255) begin
							state <= STOP;
						end else begin
							data_byte <= {in, data_byte[7:1]};
						end
					end else begin
						state <= IDLE;
					end
				end
				
				STOP: begin
					if (in == 1'b1) begin
						state <= IDLE;
						done <= 1'b1;
						out_byte <= data_byte;
					end
				end
			endcase
		end
	end
endmodule
