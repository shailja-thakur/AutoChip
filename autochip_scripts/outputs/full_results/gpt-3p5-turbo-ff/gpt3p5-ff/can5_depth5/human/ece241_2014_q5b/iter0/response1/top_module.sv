module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [1:0] state, next_state;
	
	// State encoding for A=2'b00 and B=2'b01
	localparam A = 2'b00;
	localparam B = 2'b01;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or x) begin
		case (state)
			A: begin
				if (x) begin
					next_state = B;
					z = 1;
				end else begin
					next_state = A;
					z = 0;
				end
			end
			B: begin
				if (x) begin
					next_state = B;
					z = 0;
				end else begin
					next_state = B;
					z = 1;
				end
			end
		endcase
	end
endmodule
