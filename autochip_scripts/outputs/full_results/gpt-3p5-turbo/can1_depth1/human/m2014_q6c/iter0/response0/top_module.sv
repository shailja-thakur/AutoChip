module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

reg [6:1] next_state;

always @(*) begin
	case(y)
		6'b000001: begin
			next_state = w ? 6'b100000 : 6'b000010;
		end
		6'b000010: begin
			next_state = w ? 6'b000100 : 6'b010000;
		end
		6'b000100: begin
			next_state = w ? 6'b001000 : 6'b100000;
		end
		6'b001000: begin
			next_state = w ? 6'b010000 : 6'b000001;
		end
		6'b010000: begin
			next_state = w ? 6'b100000 : 6'b000010;
		end
		6'b100000: begin
			next_state = w ? 6'b010000 : 6'b000100;
		end
		default: begin
			next_state = 6'b000001;
		end
	endcase
end

assign Y2 = next_state[5];
assign Y4 = next_state[3];

endmodule
