module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always @(*)
	begin
		case(state)
			2'b00:
				if(in == 0)
				begin
					next_state = 2'b00;
					out = 0;
				end
				else
				begin
					next_state = 2'b01;
					out = 0;
				end
				
			2'b01:
				if(in == 0)
				begin
					next_state = 2'b10;
					out = 0;
				end
				else
				begin
					next_state = 2'b01;
					out = 0;
				end
				
			2'b10:
				if(in == 0)
				begin
					next_state = 2'b00;
					out = 0;
				end
				else
				begin
					next_state = 2'b11;
					out = 0;
				end
				
			2'b11:
				if(in == 0)
				begin
					next_state = 2'b10;
					out = 1;
				end
				else
				begin
					next_state = 2'b01;
					out = 0;
				end
		endcase
	end
	
endmodule
