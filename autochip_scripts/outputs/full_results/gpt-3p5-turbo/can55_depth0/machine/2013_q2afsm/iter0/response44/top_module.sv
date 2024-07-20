module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [1:0] state;
	reg [1:0] next;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 2'b00; // state A
		end else begin
			state <= next;
		end
	end
	
	always @* begin
		case (state)
			2'b00: begin
				if (r[1]) begin
					next = 2'b01; // next state B
				end else if (r[2]) begin
					next = 2'b10; // next state C
				end else if (r[3]) begin
					next = 2'b11; // next state D
				end else begin
					next = 2'b00; // next state A
				end
			end
			
			2'b01: begin
				if (r[1]) begin
					next = 2'b01; // next state B
				end else begin
					next = 2'b00; // next state A
				end
			end
			
			2'b10: begin
				if (r[2]) begin
					next = 2'b10; // next state C
				end else begin
					next = 2'b00; // next state A
				end
			end
			
			2'b11: begin
				if (r[3]) begin
					next = 2'b11; // next state D
				end else begin
					next = 2'b00; // next state A
				end
			end
		endcase
	end
	
	always @* begin
		g[1] = (state == 2'b01) ? 1'b1 : 1'b0; // g[1] = 1 if current state is B, otherwise 0
		g[2] = (state == 2'b10) ? 1'b1 : 1'b0; // g[2] = 1 if current state is C, otherwise 0
		g[3] = (state == 2'b11) ? 1'b1 : 1'b0; // g[3] = 1 if current state is D, otherwise 0
	end

endmodule
