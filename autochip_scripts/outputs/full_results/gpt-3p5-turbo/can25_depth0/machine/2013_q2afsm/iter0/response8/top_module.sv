module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk) begin
		if (!resetn) begin
			state <= 3'b001; // A
		end else begin
			state <= next;
		end
	end

	always @(state or r) begin
		case (state)
			3'b001: begin // A
				if (r[1] == 1'b1)
					next = 3'b010; // B
				else if (r[2] == 1'b1)
					next = 3'b011; // C
				else if (r[3] == 1'b1)
					next = 3'b100; // D
				else
					next = 3'b001; // A
			end
			3'b010: begin // B
				if (r[1] == 1'b1)
					next = 3'b010; // B
				else
					next = 3'b001; // A
			end
			3'b011: begin // C
				if (r[2] == 1'b1)
					next = 3'b011; // C
				else
					next = 3'b001; // A
			end
			3'b100: begin // D
				if (r[3] == 1'b1)
					next = 3'b100; // D
				else
					next = 3'b001; // A
			end
		endcase
	end

	assign g = (state == 3'b010) ? 3'b001 : // B
	           (state == 3'b011) ? 3'b010 : // C
	           (state == 3'b100) ? 3'b100 : // D
	           3'b000;                    // A

endmodule
