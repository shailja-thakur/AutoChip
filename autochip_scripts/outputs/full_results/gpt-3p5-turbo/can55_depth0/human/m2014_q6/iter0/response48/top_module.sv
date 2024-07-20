module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	reg [2:0] state;
	
	always @(posedge clk or negedge reset) begin
		if (reset == 0) begin
			state <= 3'b000; // initial state is A
		end else begin
			case (state)
				3'b000: begin // A state
					if (w == 0)
						state <= 3'b001; // next state is B
					else
						state <= 3'b000; // next state is A
				end
				
				3'b001: begin // B state
					if (w == 0)
						state <= 3'b010; // next state is C
					else
						state <= 3'b011; // next state is D
				end
				
				3'b010: begin // C state
					if (w == 0)
						state <= 3'b100; // next state is E
					else
						state <= 3'b011; // next state is D
				end
				
				3'b011: begin // D state
					if (w == 0)
						state <= 3'b110; // next state is F
					else
						state <= 3'b000; // next state is A
				end
				
				3'b100: begin // E state
					if (w == 0)
						state <= 3'b100; // next state is E
					else
						state <= 3'b011; // next state is D
				end
				
				3'b110: begin // F state
					if (w == 0)
						state <= 3'b100; // next state is E
					else
						state <= 3'b011; // next state is D
				end
			endcase
		end
	end

	// Output logic
	always @(*) begin
		case (state)
			3'b000: begin // A state
				z = 1'b0;
			end
			
			3'b001: begin // B state
				z = 1'b0;
			end
			
			3'b010: begin // C state
				z = 1'b0;
			end
			
			3'b011: begin // D state
				z = 1'b0;
			end
			
			3'b100: begin // E state
				z = 1'b1;
			end
			
			3'b110: begin // F state
				z = 1'b1;
			end
		endcase
	end
	
endmodule
