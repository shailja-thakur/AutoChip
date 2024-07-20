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
						state <= 3; // Transition from DONE to BYTE1
				end
				1: begin // BYTE2 state
					if (in[2] == 1'b1) // transition condition from BYTE2 to BYTE3
						state <= 2;
					else
						state <= 0; // Transition from BYTE1 to BYTE1
				end
				2: begin // BYTE3 state
					state <= 3; // transition from BYTE3 to DONE
				end
				3: begin // DONE state
					if (in[2] == 1'b0) // transition condition from DONE to BYTE1
						state <= 0;
					else
						state <= 3; // Stay in DONE state
				end
				default: state <= 0;
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == 3) // done condition
			out_bytes_reg <= shift_reg[23:0]; // Assign output only when in DONE state
		shift_reg <= {in, shift_reg[23:8]}; // shift in input and shift register
	end

	assign out_bytes = out_bytes_reg;
	assign done = (state == 3);

endmodule
