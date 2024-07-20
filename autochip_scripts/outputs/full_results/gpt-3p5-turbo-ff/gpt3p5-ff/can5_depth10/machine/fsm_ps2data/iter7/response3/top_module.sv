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
	reg [2:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else
			state <= next_state;
	end
	
	always @* begin
		case (state)
			0: begin // BYTE1 state
				if (in[2] == 1'b1)
					next_state = 1; // transition condition to BYTE2
				else
					next_state = 0; // transition condition to BYTE1
			end
			
			1: begin // BYTE2 state
				if (in[2] == 1'b1)
					next_state = 2; // transition condition to BYTE3
				else
					next_state = 0; // transition condition to BYTE1
			end
			
			2: begin // BYTE3 state
				next_state = 3; // transition condition to DONE
			end
			
			3: begin // DONE state
				if (in[2] == 1'b0)
					next_state = 0; // transition condition to BYTE1
				else
					next_state = 3; // transition condition to DONE
			end
			
			default: next_state = 0;
		endcase
	end

	always @(posedge clk) begin
		shift_reg <= {in, shift_reg[7:1]}; // shift in input
		if (state == 3) // done condition
			out_bytes_reg <= shift_reg;
	end

	assign out_bytes = (state == 3) ? out_bytes_reg : 'bx;
	assign done = (state == 3);

endmodule
