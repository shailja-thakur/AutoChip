module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] shift_reg;
	reg [23:0] out_bytes_reg;
	reg [2:0] state;	
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				3'b000: begin // BYTE1 state
					if (in[2] == 1'b1) // transition condition from BYTE1 to BYTE2
						state <= 3'b001;
					else
						state <= 3'b000;
				end
				3'b001: begin // BYTE2 state
					if (in[2] == 1'b1) // transition condition from BYTE2 to BYTE3
						state <= 3'b010;
					else
						state <= 3'b000;
				end
				3'b010: begin // BYTE3 state
					state <= 3'b100; // transition from BYTE3 to DONE
				end
				3'b100: begin // DONE state
					if (in[2] == 1'b0) // transition condition from DONE to BYTE1
						state <= 3'b000;
					else
						state <= 3'b100;
				end
				default: state <= 3'b000;
			endcase
		end
	end

	always @(posedge clk) begin
		shift_reg <= {in, shift_reg[7:1]}; // shift in input
		if (state == 3'b100) // done condition
			out_bytes_reg <= shift_reg;
	end

	assign out_bytes = (state == 3'b100) ? out_bytes_reg : 'bx;
	assign done = (state == 3'b100);

endmodule
