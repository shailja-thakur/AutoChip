module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	parameter START = 2'b00;
	parameter RECEIVE = 2'b01;
	parameter STOP = 2'b10;
	reg [1:0] state;
	reg [7:0] data;
	reg done;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= START;
			data <= 8'b0;
			done <= 1'b0;
		end else begin
			case (state)
				START: begin
					if (in == 1'b0) begin
						state <= RECEIVE;
						data <= 8'b0;
					end
				end
				RECEIVE: begin
					data <= {data[6:0], in};
					if (data[7] == 1'b1) begin
						state <= STOP;
					end
				end
				STOP: begin
					if (in == 1'b1) begin
						done <= 1'b1;
						state <= START;
					end
				end
				default: state <= START;
			endcase
		end
	end
	
endmodule
