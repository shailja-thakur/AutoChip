module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	reg [3:0] state;
	reg [7:0] received_byte;
	reg [7:0] shifted_byte;
	wire start_bit;
	wire stop_bit;
	wire valid_data;
	
	assign start_bit = shifted_byte[0];
	assign stop_bit = shifted_byte[9];
	assign valid_data = (shifted_byte[1:8] == ~shifted_byte[0:7]);
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			received_byte <= 0;
			shifted_byte <= 0;
			out_byte <= 0;
			done <= 0;
		end else begin
			case (state)
				0: begin // idle state
					if (in == 1'b0) begin
						shifted_byte <= {shifted_byte[7:0], in};
						state <= 1; // transition to start bit state
					end
				end
				1: begin // start bit state
					if (in == 1'b1) begin
						shifted_byte <= {shifted_byte[7:0], in};
						state <= 2; // transition to data bits state
					end else begin
						shifted_byte <= {shifted_byte[7:0], in};
						state <= 0;
					end
				end
				2: begin // data bits state
					shifted_byte <= {shifted_byte[7:0], in};
					state <= 3; // transition to stop bit state
				end
				3: begin // stop bit state
					if (in == 1'b1) begin
						shifted_byte <= {shifted_byte[7:0], in};
						if (valid_data) begin
							received_byte <= shifted_byte[1:8];
							out_byte <= received_byte;
							done <= 1;
						end else begin
							done <= 0;
						end
						state <= 0; // transition back to idle state
					end else begin
						shifted_byte <= {shifted_byte[7:0], in};
						state <= 3; // stay in stop bit state
					end
				end
			endcase
		end
	end
endmodule
