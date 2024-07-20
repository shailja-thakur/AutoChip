module top_module (
	input wire clk,
	input wire reset,
	input wire x,
	output reg z
);

reg [2:0] y;
wire [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		y <= 3'b000;
	else
		y <= next_state;
	end
end

always @(*) begin
	case (y)
		3'b000: begin
			if (x)
				next_state = 3'b001;
			else
				next_state = 3'b000;
			z = 1'b0;
		end
		3'b001: begin
			if (x)
				next_state = 3'b100;
			else
				next_state = 3'b001;
			z = 1'b0;
		end
		3'b010: begin
			if (x)
				next_state = 3'b001;
			else
				next_state = 3'b010;
			z = 1'b0;
		end
		3'b011: begin
			if (x)
				next_state = 3'b010;
			else
				next_state = 3'b001;
			z = 1'b1;
		end
		3'b100: begin
			if (x)
				next_state = 3'b100;
			else
				next_state = 3'b011;
			z = 1'b1;
		end
	endcase
end

endmodule
