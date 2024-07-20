module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	reg [2:0] state;
	reg [7:0] shift_reg;
	reg [2:0] count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			shift_reg <= 0;
			count <= 0;
			out_byte <= 0;
			done <= 0;
		end else begin
			case (state)
				0: begin // IDLE state
					if (in == 1) begin
						state <= 0;
					end else if (in == 0) begin
						state <= 1;
						shift_reg <= 0;
						count <= 0;
					end
				end
				1: begin // START_BIT state
					state <= 2;
				end
				2: begin // RECEIVE_BIT0 state
					shift_reg[count] <= in;
					count <= count + 1;
					if (count == 7) begin
						state <= 3;
						count <= 0;
					end
				end
				3: begin // RECEIVE_BIT1 state
					shift_reg[count] <= in;
					if (count == 7) begin
						state <= 4;
						count <= 0;
					end
				end
				4: begin // STOP_BIT state
					if (in == 1) begin
						out_byte <= shift_reg;
						done <= 1;
						state <= 0;
					end else if (in == 0) begin
						state <= 5;
						count <= 0;
					end
				end
				5: begin // WAIT_FOR_STOP_BIT state
					if (in == 1) begin
						state <= 0;
					end
				end
			endcase
		end
	end

endmodule
