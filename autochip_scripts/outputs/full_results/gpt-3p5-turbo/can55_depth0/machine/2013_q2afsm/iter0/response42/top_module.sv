module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);
	reg [1:0] state;
	reg [1:0] next;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 2'b00; // Set state to A
		end else begin
			state <= next; // Set state to next
		end
	end
	
	always @* begin
		case (state)
			2'b00: begin // State A
				if (r[2]) begin // If r[2] is high, next state is C
					next = 2'b10;
				end else if (r[1]) begin // If r[1] is high, next state is B
					next = 2'b01;
				end else if (r[0]) begin // If r[0] is high, next state is D
					next = 2'b11;
				end else begin // If none of the bits of r are high, next state is A
					next = 2'b00;
				end
			end
			
			2'b01: begin // State B
				if (r[1]) begin // If r[1] is high, next state is B
					next = 2'b01;
				end else begin // If r[1] is low, next state is A
					next = 2'b00;
				end
			end
			
			2'b10: begin // State C
				if (r[2]) begin // If r[2] is high, next state is C
					next = 2'b10;
				end else begin // If r[2] is low, next state is A
					next = 2'b00;
				end
			end
			
			2'b11: begin // State D
				if (r[0]) begin // If r[0] is high, next state is D
					next = 2'b11;
				end else begin // If r[0] is low, next state is A
					next = 2'b00;
				end
			end
		endcase
	end
	
	always @* begin
		case (state)
			2'b01: g[2] = 1'b1; // Set g[2] to high in state B
			2'b10: g[1] = 1'b1; // Set g[1] to high in state C
			2'b11: g[0] = 1'b1; // Set g[0] to high in state D
			default: g = 3'b000; // Set all bits of g to low in other states
		endcase
	end
endmodule
