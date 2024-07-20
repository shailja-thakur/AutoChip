module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	// state enumeration
	typedef enum logic [1:0] {
		A, B, C, D
	} state_type;
	
	// state register
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		// reset state to A on areset rising edge
		if (areset) begin
			state <= A;
		end
		// update state on clk rising edge
		else begin
			case (state)
				A: begin
					if (in)
						state <= B;
					else
						state <= A;
				end
				B: begin
					if (in)
						state <= B;
					else
						state <= C;
				end
				C: begin
					if (in)
						state <= D;
					else
						state <= A;
				end
				D: begin
					if (in)
						state <= B;
					else
						state <= C;
				end
			endcase
		end
	end
	
	// set out to 1 when state is D
	assign out = (state == D);
	
endmodule
