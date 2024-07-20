module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [3:0] state;
	reg [3:1] next_state;

	always @(posedge clk) begin
		if (resetn == 0)
			state <= 4'b0000;
		else
			state <= next_state;
	end

	always @* begin
		case(state)
			4'b0000: begin
				if (r[1] == 1)
					next_state = 4'b0010;
				else if (r[2] == 1)
					next_state = 4'b0100;
				else if (r[3] == 1)
					next_state = 4'b1000;
				else
					next_state = 4'b0001;
			end
			4'b0010: begin
				if (r[1] == 1)
					next_state = 4'b0010;
				else
					next_state = 4'b0001;
			end
			4'b0100: begin
				if (r[2] == 1)
					next_state = 4'b0100;
				else
					next_state = 4'b0001;
			end
			4'b1000: begin
				if (r[3] == 1)
					next_state = 4'b1000;
				else
					next_state = 4'b0001;
			end
			default: next_state = 4'b0001;
		endcase
	end

	assign g = (state == 4'b0010) ? 3'b001 :
	           (state == 4'b0100) ? 3'b010 :
	           (state == 4'b1000) ? 3'b100 :
	           3'b000;

endmodule
