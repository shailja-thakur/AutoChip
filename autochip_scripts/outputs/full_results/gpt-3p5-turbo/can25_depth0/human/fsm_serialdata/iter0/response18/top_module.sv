module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	reg [8:0] state; // state register
	reg [7:0] data_reg; // data register

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
		end else begin
			case(state)
				0: begin // idle state, waiting for start bit
					if (in) begin
						state <= 1;
					end
				end

				1: begin // start bit detected, waiting for data bits
					state <= 2;
					data_reg <= 0;
				end

				2: begin // receiving data bits
					if (in) begin
						data_reg <= {data_reg[6:0], in};
						state <= (state == 9) ? 10 : (state + 1);
					end else begin
						state <= 1; // start bit not detected, go back to waiting for start bit
					end
				end

				10: begin // stop bit detected
					state <= 0;
				end

				default: state <= 0; // default to idle state
			endcase
		end
	end

	assign out_byte = done ? data_reg : 8'hzz; // output the received data byte when done is high, don't-care otherwise
	assign done = (state == 10); // assert done when stop bit is detected
endmodule
