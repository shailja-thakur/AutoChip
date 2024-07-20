module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always @* begin
		case(state)
			2'b00: begin // A
				if(in)
					next_state = 2'b01; // B
				else
					next_state = 2'b00; // A
				out = 1'b0;
			end
			
			2'b01: begin // B
				if(in)
					next_state = 2'b01; // B
				else
					next_state = 2'b10; // C
				out = 1'b0;
			end
			
			2'b10: begin // C
				if(in)
					next_state = 2'b11; // D
				else
					next_state = 2'b00; // A
				out = 1'b0;
			end
			
			2'b11: begin // D
				if(in)
					next_state = 2'b10; // C
				else
					next_state = 2'b01; // B
				out = 1'b1;
			end
		endcase
	end
	
endmodule
