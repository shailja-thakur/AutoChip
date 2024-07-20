module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg received_start;
reg [7:0] data_byte;
reg received_stop;

// Define the states
parameter IDLE = 0;
parameter START_BIT = 1;
parameter RECEIVE_DATA = 2;
parameter STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		received_start <= 0;
		data_byte <= 0;
		received_stop <= 0;
		end
	else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
					received_start <= 1;
				end
				else begin
					state <= IDLE;
					received_start <= 0;
				end
			end
			
			START_BIT: begin
				state <= RECEIVE_DATA;
				data_byte <= in;
			end
			
			RECEIVE_DATA: begin
				state <= RECEIVE_DATA;
				data_byte <= {data_byte[6:0], in};
				
				if (received_stop) begin
					state <= IDLE;
					done <= 1;
				end
				else if (data_byte == 8'b11111111) begin
					state <= STOP_BIT;
				end
			end

			STOP_BIT: begin
				if (in == 1'b1) begin
					state <= IDLE;
					received_stop <= 1;
				end
				else begin
					state <= RECEIVE_DATA;
				end
			end
		endcase
	end
end

endmodule
