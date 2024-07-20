module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

	reg [2:0] state;
	reg [2:0] next_state;
	reg [9:0] counter;
	reg [7:0] data_byte;
	reg start_bit_detected;
	reg stop_bit_detected;
	parameter IDLE = 3'd0;
	parameter START_BIT = 3'd1;
	parameter DATA_BITS = 3'd2;
	parameter STOP_BIT = 3'd3;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data_byte <= 8'b0;
			start_bit_detected <= 0;
			stop_bit_detected <= 0;
		end
		else begin
			state <= next_state;
			data_byte <= {data_byte[6:0], in};
			start_bit_detected <= 0;
			stop_bit_detected <= 0;
            counter <= counter + 1;
            
			case (state)
				IDLE: begin
					if (in == 0) begin
						next_state <= START_BIT;
						start_bit_detected <= 1;
                        counter <= 0;
					end
					else begin
						next_state <= IDLE;
					end
				end
				START_BIT: begin
					next_state <= DATA_BITS;
				end
				DATA_BITS: begin
					if (counter == 9) begin
						next_state <= STOP_BIT;
					end
                    else begin
						next_state <= DATA_BITS;
					end
				end
				STOP_BIT: begin
					if (in == 1) begin
						next_state <= IDLE;
						stop_bit_detected <= 1;
					end
					else begin
						next_state <= STOP_BIT;
					end
				end
				default: begin
					next_state <= IDLE;
				end
			endcase
		end
	end

	assign out_byte = data_byte;
	assign done = stop_bit_detected;

endmodule
