module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk) begin
		if (!resetn)
			state <= 3'b001;  // A
		else
			state <= next;
	end

	always @(state or r) begin
		case (state)
			3'b001: begin  // A
				if (r[1])
					next = 3'b010;  // B
				else if (r[2])
					next = 3'b011;  // C
				else if (r[3])
					next = 3'b100;  // D
				else
					next = 3'b001;  // A
			end
			3'b010: begin  // B
				if (r[1])
					next = 3'b010;  // B
				else
					next = 3'b001;  // A
			end
			3'b011: begin  // C
				if (r[2])
					next = 3'b011;  // C
				else
					next = 3'b001;  // A
			end
			3'b100: begin  // D
				if (r[3])
					next = 3'b100;  // D
				else
					next = 3'b001;  // A
			end
			default: next = 3'b001;  // A
		endcase
	end

	assign g[1] = (state == 3'b010);  // B
	assign g[2] = (state == 3'b011);  // C
	assign g[3] = (state == 3'b100);  // D
endmodule
