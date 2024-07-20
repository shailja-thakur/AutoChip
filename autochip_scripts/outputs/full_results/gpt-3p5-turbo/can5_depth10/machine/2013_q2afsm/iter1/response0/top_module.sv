module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state, next_state;
	always@(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 3'b001;
		end
		else begin
			state <= next_state;
		end
	end
	
	always@(state, r) begin
		case (state)
			3'b001: begin
				if (r[1]) begin
					next_state = 3'b010;
				end
				else if (r[2]) begin
					next_state = 3'b011;
				end
				else if (r[3]) begin
					next_state = 3'b100;
				end
				else begin
					next_state = 3'b001;
				end
			end
			
			3'b010: begin
				if (r[1]) begin
					next_state = 3'b010;
				end
				else begin
					next_state = 3'b001;
				end
			end
			
			3'b011: begin
				if (r[2]) begin
					next_state = 3'b011;
				end
				else begin
					next_state = 3'b001;
				end
			end
			
			3'b100: begin
				if (r[3]) begin
					next_state = 3'b100;
				end
				else begin
					next_state = 3'b001;
				end
			end
			
			default: begin
				next_state = 3'b001;
			end
		endcase
	end
	
	always@(state) begin
		case (state)
			3'b010: g = 3'b001;
			3'b011: g = 3'b010;
			3'b100: g = 3'b100;
			default: g = 3'b000;
		endcase
	end
endmodule
