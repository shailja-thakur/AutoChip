module top_module (
	input clk,
	input reset,
	input x,
	output reg z,
	output reg [2:0] y
);

reg [2:0] next_state;
always @(posedge clk or posedge reset) begin
	if (reset) begin
		y <= 3'b000;
		z <= 1'b0;
	end else begin
		case(y)
			3'b000: begin
				if(x)
					next_state = 3'b001;
				else
					next_state = 3'b000;
				z <= 1'b0;
			end
			3'b001: begin
				if(x)
					next_state = 3'b100;
				else
					next_state = 3'b001;
				z <= 1'b0;
			end
			3'b010: begin
				if(x)
					next_state = 3'b001;
				else
					next_state = 3'b010;
				z <= 1'b0;
			end
			3'b011: begin
				if(x)
					next_state = 3'b010;
				else
					next_state = 3'b001;
				z <= 1'b1;
			end
			3'b100: begin
				if(x)
					next_state = 3'b100;
				else
					next_state = 3'b011;
				z <= 1'b1;
			end
		endcase
		y <= next_state;
	end
end

endmodule
