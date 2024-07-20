module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data_byte;
reg [2:0] count;

parameter IDLE = 0;
parameter START = 1;
parameter RECEIVE = 2;
parameter STOP = 3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data_byte <= 8'b0;
		count <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START;
					count <= 1;
				end
				data_byte <= 8'b0;
			end
			START: begin
				if (count < 8) begin
					state <= RECEIVE;
					count <= count + 1;
				end else if (count == 8) begin
					if (in == 1'b1) begin
						state <= STOP;
					end else begin
						state <= IDLE;
					end
				end
				data_byte <= {data_byte[6:0], in};
			end
			RECEIVE: begin
				if (count < 8) begin
					state <= RECEIVE;
					count <= count + 1;
				end else if (count == 8) begin
					if (in == 1'b1) begin
						state <= STOP;
					end else begin
						state <= IDLE;
					end
				end
				data_byte <= {data_byte[6:0], in};
			end
			STOP: begin
				if (in == 1'b1) begin
					state <= IDLE;
					done <= 1;
					out_byte <= data_byte;
				end
			end
		endcase
	end
end

endmodule
