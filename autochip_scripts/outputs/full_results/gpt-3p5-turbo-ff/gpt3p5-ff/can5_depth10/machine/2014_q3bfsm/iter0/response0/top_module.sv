module top_module (
	input wire clk,
	input wire reset,
	input wire x,
	output reg z
);
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if(reset)
			state <= 3'b001;
		else begin
			case(state)
				3'b000: if(x == 1'b0) state <= 3'b000; else state <= 3'b001;
				3'b001: if(x == 1'b0) state <= 3'b001; else state <= 3'b010;
				3'b010: if(x == 1'b0) state <= 3'b010; else state <= 3'b001;
				3'b011: if(x == 1'b0) state <= 3'b010; else state <= 3'b011;
				3'b100: if(x == 1'b0) state <= 3'b010; else state <= 3'b100;
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			3'b011, 3'b100: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end
endmodule
