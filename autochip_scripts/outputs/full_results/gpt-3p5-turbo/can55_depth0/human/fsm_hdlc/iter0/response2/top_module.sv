module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	reg [2:0] state;
	parameter [2:0] START = 3'b000;
	parameter [2:0] FIND_0 = 3'b001;
	parameter [2:0] FIND_1 = 3'b010;
	parameter [2:0] FLAG = 3'b011;
	parameter [2:0] ERR = 3'b100;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= START;
		end else begin
			case (state)
				START: begin
					if (in) begin
						state <= FIND_1;
					end else begin
						state <= START;
					end
				end
				
				FIND_0: begin
					if (in) begin
						state <= FIND_1;
					end else begin
						state <= START;
					end
				end
				
				FIND_1: begin
					if (in) begin
						state <= FLAG;
					end else begin
						state <= FIND_0;
					end
				end
				
				FLAG: begin
					if (in) begin
						state <= ERR;
					end else begin
						state <= START;
					end
				end
				
				ERR: begin
					if (in) begin
						state <= ERR;
					end else begin
						state <= FIND_0;
					end
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (state)
			START: begin
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			
			FIND_0: begin
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			
			FIND_1: begin
				disc <= 1;
				flag <= 0;
				err <= 0;
			end
			
			FLAG: begin
				disc <= 0;
				flag <= 1;
				err <= 0;
			end
			
			ERR: begin
				disc <= 0;
				flag <= 0;
				err <= 1;
			end
		endcase
	end

endmodule
