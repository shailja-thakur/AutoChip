module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] shift_reg;
	reg [23:0] out_bytes_reg;
	reg [3:0] state;	
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				4'b0000: begin // BYTE1 state
					if (in[2] == 1'b1) // transition condition from BYTE1 to BYTE2
						state <= 4'b0001;
				end
				
				4'b0001: begin // BYTE2 state
					if (in[2] == 1'b1) // transition condition from BYTE2 to BYTE3
						state <= 4'b0010;
				end
				
				4'b0010: begin // BYTE3 state
					if (in[2] == 1'b0) // transition condition from BYTE3 to DONE
						state <= 4'b0100;
				end
				
				4'b0100: begin // DONE state
					if (in[2] == 1'b0) // transition condition from DONE to BYTE1
						state <= 4'b0000;
					else
						state <= 4'b0100;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == 4'b0100) // done condition
			out_bytes_reg <= {shift_reg[15:0], in};
		shift_reg <= {shift_reg[6:0], in}; // shift in input
	end

	assign out_bytes = (state == 4'b0100) ? out_bytes_reg : 'bz;
	assign done = (state == 4'b0100);

endmodule
