module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// State declaration
	reg [2:0] state;
	
	// State assignment
	localparam IDLE = 3'b000;
	localparam S1 = 3'b001;
	localparam S2 = 3'b010;
	localparam S3 = 3'b011;
	localparam FOUND = 3'b100;
	
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= IDLE;
		else
		begin
			case (state)
				IDLE:
				begin
					if (data)
						state <= S1;
				end
				
				S1:
				begin
					if (data)
						state <= S1;
					else
						state <= S2;
				end
				
				S2:
				begin
					if (data)
						state <= S3;
					else
						state <= IDLE;
				end
				
				S3:
				begin
					if (data)
						state <= FOUND;
					else
						state <= IDLE;
				end
				
				FOUND:
				begin
					state <= FOUND;
				end
			endcase
		end
	end
	
	// Output assignment
	assign start_shifting = (state == FOUND);
	
endmodule
