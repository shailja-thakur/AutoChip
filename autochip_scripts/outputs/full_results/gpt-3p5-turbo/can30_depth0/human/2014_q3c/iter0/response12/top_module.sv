module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y_next;

always @(posedge clk) begin
	case (y)
		3'b000: begin
			Y_next = x ? 3'b001 : 3'b000;
			z = 0;
		end
		3'b001: begin
			Y_next = x ? 3'b100 : 3'b001;
			z = 0;
		end
		3'b010: begin
			Y_next = x ? 3'b001 : 3'b010;
			z = 0;
		end
		3'b011: begin
			Y_next = x ? 3'b010 : 3'b001;
			z = 1;
		end
		3'b100: begin
			Y_next = x ? 3'b100 : 3'b011;
			z = 1;
		end
	endcase
	
	Y0 <= Y_next[0];
end

endmodule
