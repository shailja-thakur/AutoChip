module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	
	// Initialize state to A
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case (state)
				3'b000: begin
					if (x) begin
						state <= 3'b001;  // transition to B
					else
						state <= 3'b000;  // stay in A
					end
				end
				3'b001: begin
					if (x) begin
						state <= 3'b100;  // transition to E
					else
						state <= 3'b001;  // stay in B
					end
				end
				3'b010: begin
					if (x) begin
						state <= 3'b001;  // transition to B
					else
						state <= 3'b010;  // stay in C
					end
				end
				3'b011: begin
					if (x) begin
						state <= 3'b010;  // transition to C
					else
						state <= 3'b011;  // stay in D
					end
				end
				3'b100: begin
					if (x) begin
						state <= 3'b100;  // stay in E
					else
						state <= 3'b011;  // transition to D
					end
				end
				default: begin
					state <= 3'b000;  // default to A
				end
			endcase
		end
	end
	
	// Output high when state is D or E
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			z <= 1'b0;
		end else begin
			if (state == 3'b011 || state == 3'b100) begin
				z <= 1'b1;
			end else begin
				z <= 1'b0;
			end
		end
	end

endmodule
