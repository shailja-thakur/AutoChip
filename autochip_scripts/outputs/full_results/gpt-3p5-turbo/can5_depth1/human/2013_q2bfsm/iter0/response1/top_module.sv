module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	reg [2:0] state, next_state;
	always @ (posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 3'b000;
		end else begin
			state <= next_state;
		end
	end
	
	always @* begin
		case (state)
			3'b000: begin // State A
				f = 1'b0;
				if (resetn) begin
					next_state = 3'b001;
				end
			end
			
			3'b001: begin // State B
				f = 1'b1;
				if (x) begin
					next_state = 3'b010;
				end else begin
					next_state = 3'b001;
				end
			end
			
			3'b010: begin // State C
				if (x) begin
					next_state = 3'b011;
				end else begin
					next_state = 3'b000;
				end
			end
			
			3'b011: begin // State D
				if (x) begin
					next_state = 3'b100;
					g = 1'b0;
				end else begin
					next_state = 3'b011;
					g = 1'b1;
				end
			end
			
			3'b100: begin // State E
				if (y) begin
					next_state = 3'b111;
				end else begin
					next_state = 3'b101;
				end
				g = 1'b1;
			end
			
			3'b101: begin // State F
				if (y) begin
					next_state = 3'b111;
				end else begin
					next_state = 3'b101;
				end
				g = 1'b0;
			end
			
			3'b111: begin // State G
				next_state = 3'b111;
				g = 1'b1;
			end
		endcase
	end
endmodule
