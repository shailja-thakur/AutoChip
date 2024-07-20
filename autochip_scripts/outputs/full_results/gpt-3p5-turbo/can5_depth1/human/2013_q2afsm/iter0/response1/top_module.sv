module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
reg g1, g2, g3;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		state <= 3'b001;
	else
		state <= next_state;
end


always @(state, r) begin
	case (state)
		3'b001: begin // A
			if (r == 3'b000)
				next_state = 3'b001;
			else if (r[1])
				next_state = 3'b010; // B
			else if (r[2])
				next_state = 3'b011; // C
			else if (r == 3'b000)
				next_state = 3'b100; // D
		end
		3'b010: begin // B
			if (g1)
				next_state = 3'b010;
			else if (~r[1])
				next_state = 3'b001; // A
		end
		3'b011: begin // C
			if (g2)
				next_state = 3'b011;
			else if (~r[2])
				next_state = 3'b001; // A
		end
		3'b100: begin // D
			next_state = 3'b001; // A
		end
	endcase
end

always @(state) begin
	g1 = (state == 3'b010);
	g2 = (state == 3'b011);
	g3 = (state == 3'b001);
end

assign g = {g3, g2, g1};

endmodule
