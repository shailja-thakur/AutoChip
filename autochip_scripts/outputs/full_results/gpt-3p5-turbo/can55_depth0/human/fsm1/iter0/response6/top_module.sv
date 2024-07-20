module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	parameter B = 0;
	parameter A = 1;
	parameter NUM_STATES = 2;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else begin
			case (state)
				B: begin
					if (in)
						state <= A;
					else
						state <= B;
				end
				A: begin
					if (in)
						state <= A;
					else
						state <= B;
				end
				default: state <= B;
			endcase
		end
	end
	
	assign out = (state == A);
	
endmodule
