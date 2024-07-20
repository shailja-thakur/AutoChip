module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state;
	always @(posedge clk or negedge resetn)
	begin
		if (~resetn)
			state <= 3'b001;
		else
			state <= next;
	end
	
	reg [2:1] next;
	always @*
	begin
		case (state)
			3'b001: if (r[3]) next = 3'b100;
					else if (r[2]) next = 3'b011;
					else if (r[1]) next = 3'b010;
					else next = 3'b001;
					
			3'b010: if (r[1]) next = 3'b010;
					else next = 3'b001;
					
			3'b011: if (r[2]) next = 3'b011;
					else next = 3'b001;
					
			3'b100: if (r[3]) next = 3'b100;
					else next = 3'b001;
					
			default: next = 3'b001;
		endcase
	end
	
	assign g = (state == 3'b010) ? 3'b001 : (state == 3'b011) ? 3'b010 : (state == 3'b100) ? 3'b100 : 3'b000;
	
endmodule
