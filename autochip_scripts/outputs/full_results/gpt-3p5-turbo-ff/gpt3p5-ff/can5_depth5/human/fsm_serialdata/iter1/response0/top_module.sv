module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

	reg [2:0] state;
	reg [7:0] data_byte;
	reg start_bit_detected;
	reg stop_bit_detected;

	parameter IDLE = 3'b00;
	parameter START_BIT = 3'b01;
	parameter DATA_BITS = 3'b10;
	parameter STOP_BIT = 3'b11;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data_byte <= 8'b0;
			start_bit_detected <= 0;
			stop_bit_detected <= 0;
		end
		else begin
			case (state)
				IDLE: begin
					if (in == 1'b0) begin
						state <= START_BIT;
						start_bit_detected <= 1;
					end
				end
				START_BIT: begin
					state <= DATA_BITS;
				end
				DATA_BITS: begin
					data_byte <= {data_byte[6:0], in};
					state <= DATA_BITS + 1;
				end
				8'd9: begin
					state <= STOP_BIT;
				end
				STOP_BIT: begin
					if (in == 1'b1) begin
						state <= IDLE;
						stop_bit_detected <= 1;
						out_byte <= data_byte;
						done <= 1'b1;
					end
				end
			endcase
		end
	end
	
	// If stop bit does not appear when expected, FSM waits until it finds a stop bit before attempting to receive the next byte
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			out_byte <= 8'b0;
			done <= 1'b0;
		end
		else begin
			if (state != STOP_BIT && in == 1'b1) begin
				state <= IDLE;
				stop_bit_detected <= 0;
			end
			else if (state != STOP_BIT && in == 1'b0) begin
				stop_bit_detected <= 0;
			end
		end
	end
	
endmodule
