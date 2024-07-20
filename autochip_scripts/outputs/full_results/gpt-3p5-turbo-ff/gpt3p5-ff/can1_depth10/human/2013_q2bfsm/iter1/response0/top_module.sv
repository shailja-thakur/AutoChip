module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

reg [1:0] state;

always @(posedge clk, negedge resetn)
begin
	if (~resetn)
		state <= 2'b0; // state A
	else
	begin
		case(state)
			2'b0: // state A
			begin
				if (resetn)
					state <= 2'b1; // state B
			end
			
			2'b1: // state B
			begin
				f <= 1'b1;
				state <= 2'b2; // state C
			end
			
			2'b2: // state C
			begin
				if ((x == 1'b1) && (x == 1'b0) && (x == 1'b1))
					state <= 2'b3; // state D
			end
			
			2'b3: // state D
			begin
				g <= 1'b1;
				if (y == 1'b1)
					state <= 2'b4; // state E
				else if (y == 1'b0)
					state <= 2'b5; // state F
			end
			
			2'b4: // state E
			begin
				if (y == 1'b1)
					g <= 1'b1;
				else
					state <= 2'b5; // state F
			end
			
			2'b5: // state F
			begin
				g <= 1'b0;
				if (resetn)
					state <= 2'b0; // state A
			end
		endcase
	end
end

endmodule
