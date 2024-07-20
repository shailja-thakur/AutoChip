module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	// Registers for state machine and shift register
	reg [1:0] state;
	reg [7:0] register [2:0];
	reg [23:0] out_reg;
	
	// Combinational logic for next state
	always @(*) begin
		case (state)
			BYTE1: begin
				if (in[2] == 1)
					state = BYTE2;
				else
					state = BYTE1;
			end
			
			BYTE2: begin
				if (in[2] == 1)
					state = BYTE3;
				else
					state = BYTE2;
			end
			
			BYTE3: begin
				if (in[2] == 1)
					state = DONE;
				else
					state = BYTE3;
			end
			
			DONE: begin
				if (reset == 1 || in[2] == 0)
					state = BYTE1;
				else
					state = DONE;
			end
		endcase
	end
	
	// Sequential logic for shift register and output
	always @(posedge clk) begin
		if (reset == 1)
			out_reg <= 0;
		else begin
			case (state)
				BYTE1: register[0] <= in;
				BYTE2: register[1] <= in;
				BYTE3: register[2] <= in;
				DONE: out_reg <= {register[2], register[1], register[0]};
				default: out_reg <= out_reg;
			endcase
		end
	end
	
	assign out_bytes = out_reg;
	assign done = (state == DONE) ? 1'b1 : 1'b0;
endmodule
