module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [3:1] state;
	reg [3:1] current_state;
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= 3'b001; // A
		else
			state <= current_state;
	end

	always @(*) begin
		case (state)
			3'b001: begin // A
				if (r[1])
					current_state = 3'b010; // B
				else if (r[2])
					current_state = 3'b011; // C
				else if (r[3])
					current_state = 3'b100; // D
				else
					current_state = 3'b001; // A
			end
			
			3'b010: begin // B
				if (r[1])
					current_state = 3'b010; // B
				else
					current_state = 3'b001; // A
			end
			
			3'b011: begin // C
				if (r[2])
					current_state = 3'b011; // C
				else
					current_state = 3'b001; // A
			end
			
			3'b100: begin // D
				if (r[3])
					current_state = 3'b100; // D
				else
					current_state = 3'b001; // A
			end
		endcase
	end
	
	assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // B
	assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // C
	assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // D
	
endmodule
