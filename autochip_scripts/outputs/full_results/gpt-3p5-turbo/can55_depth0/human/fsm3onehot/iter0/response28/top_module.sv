module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	always @(*)
	begin
		case(state)
			4'b0001: // A
				begin
					if(in)
						begin
							next_state = 4'b0010; // B
							out = 1'b0;
						end
					else
						begin
							next_state = 4'b0001; // A
							out = 1'b0;
						end
				end
			
			4'b0010: // B
				begin
					if(in)
						begin
							next_state = 4'b0010; // B
							out = 1'b0;
						end
					else
						begin
							next_state = 4'b0100; // C
							out = 1'b0;
						end
				end
			
			4'b0100: // C
				begin
					if(in)
						begin
							next_state = 4'b0001; // A
							out = 1'b0;
						end
					else
						begin
							next_state = 4'b1000; // D
							out = 1'b0;
						end
				end
			
			4'b1000: // D
				begin
					if(in)
						begin
							next_state = 4'b0100; // C
							out = 1'b1;
						end
					else
						begin
							next_state = 4'b0010; // B
							out = 1'b0;
						end
				end
		endcase
	end
	
endmodule
