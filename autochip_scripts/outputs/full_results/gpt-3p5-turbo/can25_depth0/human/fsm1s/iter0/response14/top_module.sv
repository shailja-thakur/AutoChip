module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg out;
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10; // B
		else begin
			case(state)
				2'b00: if (in) state <= 2'b01; else state <= 2'b10;
				2'b01: if (in) state <= 2'b01; else state <= 2'b10;
				2'b10: if (in) state <= 2'b11; else state <= 2'b00;
				2'b11: if (in) state <= 2'b01; else state <= 2'b10;
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			2'b00: out = 0;
			default: out = 1;
		endcase
	end
	
endmodule
