module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			state <= 3'b001;
		end else begin
			case(state)
				3'b001: begin // state A
					if (x == 1'b0) begin
						state <= 3'b001;
					end else begin
						state <= 3'b010; // next state B
					end
				end
				
				3'b010: begin // state B
					if (x == 1'b0) begin
						state <= 3'b010;
					end else begin
						state <= 3'b101; // next state E
					end
				end
				
				3'b011: begin // state C
					if (x == 1'b0) begin
						state <= 3'b011;
					end else begin
						state <= 3'b010; // next state B
					end
				end
				
				3'b100: begin // state D
					if (x == 1'b0) begin
						state <= 3'b010; // next state B
					end else begin
						state <= 3'b011; // next state C
					end
				end
				
				3'b101: begin // state E
					if (x == 1'b0) begin
						state <= 3'b100; // next state D
					end else begin
						state <= 3'b101; // next state E
					end
				end
				
				default: begin
					state <= 3'b001;
				end
			endcase
		end
	end
	
	always @(state, x) begin
		if (state == 3'b101 || state == 3'b100) begin // state D or E
			z <= 1'b1;
		end else begin
			z <= 1'b0;
		end
	end
	
endmodule
