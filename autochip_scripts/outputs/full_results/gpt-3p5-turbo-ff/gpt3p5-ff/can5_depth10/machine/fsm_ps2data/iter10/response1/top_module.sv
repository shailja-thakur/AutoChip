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
			state <= 0;
		else begin
			case (state)
				0: begin // BYTE1 state
					if (in[2] == 1'b1) // transition condition from BYTE1 to BYTE2
						state <= 1;
					else
						state <= 0;
				end
				1: begin // BYTE2 state
					if (in[2] == 1'b1) // transition condition from BYTE2 to BYTE3
						state <= 2;
					else
						state <= 0;
				end
				2: begin // BYTE3 state
					if (in[2] == 1'b0) // transition condition from BYTE3 to DONE
						state <= 3;
					else
						state <= 2;
				end
				3: begin // DONE state
					if (in[2] == 1'b0) // transition condition from DONE to BYTE1
						state <= 0;
					else
						state <= 3;
				end
				default: state <= 0;
			endcase
		end
	end

	always @(posedge clk) begin
		shift_reg <= {shift_reg[7:1], in}; // shift in input
		if (state == 3) // done condition
			out_bytes_reg <= shift_reg;
	end

	assign out_bytes = out_bytes_reg;
	assign done = (state == 3);

endmodule
