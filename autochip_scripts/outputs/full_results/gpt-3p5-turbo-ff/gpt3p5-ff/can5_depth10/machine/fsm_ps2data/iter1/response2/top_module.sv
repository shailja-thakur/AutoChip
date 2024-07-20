module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] shift_reg;
	reg [23:0] out_bytes_reg;
	reg [1:0] state;	
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else begin
			case (state)
				2'b00: begin // BYTE1 state
					if (in[2] == 1'b1) // transition condition from BYTE1 to BYTE2
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				2'b01: begin // BYTE2 state
					if (in[2] == 1'b1) // transition condition from BYTE2 to BYTE3
						state <= 2'b10;
					else
						state <= 2'b00;
				end
				2'b10: begin // BYTE3 state
					state <= 2'b11; // transition from BYTE3 to DONE
				end
				2'b11: begin // DONE state
					if (in[2] == 1'b0) // transition condition from DONE to BYTE1
						state <= 2'b00;
					else
						state <= 2'b11;
				end
				default: state <= 2'b00;
			endcase
		end
	end

	always @(posedge clk) begin
		shift_reg <= {in, shift_reg[7:1]}; // shift in input
		if (state == 2'b11) // done condition
			out_bytes_reg <= {shift_reg[7:0], 16'b0};
	end

	assign out_bytes = out_bytes_reg;
	assign done = (state == 2'b11);

endmodule
