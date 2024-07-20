module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [1:0] state;
	reg [1:0] next;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 2'b00; // initialize state to A
		end else begin
			state <= next;
		end
	end
	
	always @* begin
		case (state)
			2'b00: begin // state A
				if (r[3]) begin
					next = 2'b11; // next state is D
				end else if (r[2]) begin
					next = 2'b10; // next state is C
				end else if (r[1]) begin
					next = 2'b01; // next state is B
				end else begin
					next = 2'b00; // next state is A
				end
			end
			
			2'b01: begin // state B
				if (r[1]) begin
					next = 2'b01; // next state is B
				end else begin
					next = 2'b00; // next state is A
				end
			end
			
			2'b10: begin // state C
				if (r[2]) begin
					next = 2'b10; // next state is C
				end else begin
					next = 2'b00; // next state is A
				end
			end
			
			2'b11: begin // state D
				if (r[3]) begin
					next = 2'b11; // next state is D
				end else begin
					next = 2'b00; // next state is A
				end
			end
		endcase
	end
	
	assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0; // g[1] is high when state is B
	assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0; // g[2] is high when state is C
	assign g[3] = (state == 2'b11) ? 1'b1 : 1'b0; // g[3] is high when state is D
endmodule
