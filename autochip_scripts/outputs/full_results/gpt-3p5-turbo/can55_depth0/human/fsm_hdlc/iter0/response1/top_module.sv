module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	// Define states
	parameter [2:0] S_IDLE = 3'b000;
	parameter [2:0] S_S1 = 3'b001;
	parameter [2:0] S_S2 = 3'b010;
	parameter [2:0] S_S3 = 3'b011;
	parameter [2:0] S_S4 = 3'b100;
	parameter [2:0] S_S5 = 3'b101;
	parameter [2:0] S_S6 = 3'b110;
	
	// Define next state variable
	reg [2:0] state;
	
	// Define outputs
	reg disc;
	reg flag;
	reg err;
	
	// Define internal signal
	reg prev_in;
	reg [3:0] ones_count;
	
	// Next state and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S_IDLE;
			disc <= 0;
			flag <= 0;
			err <= 0;
			ones_count <= 0;
		end else begin
			prev_in <= in;
			case (state)
				S_IDLE: begin
					if (in) begin
						state <= S_S1;
						ones_count <= 1;
					end
				end
				
				S_S1: begin
					if (in) begin
						ones_count <= ones_count + 1;
						if (ones_count == 6) begin
							state <= S_S2;
						end
					end else begin
						ones_count <= 0;
						state <= S_IDLE;
						disc <= 0;
						flag <= 0;
						err <= 0;
					end
				end
				
				S_S2: begin
					if (in) begin
						ones_count <= ones_count + 1;
						if (ones_count == 7) begin
							state <= S_S3;
						end else if (ones_count > 7) begin
							state <= S_S6;
							err <= 1;
						end
					end else begin
						ones_count <= 0;
						state <= S_IDLE;
						disc <= 0;
						flag <= 0;
						err <= 0;
					end
				end
				
				S_S3: begin
					if (in) begin
						ones_count <= ones_count + 1;
						if (ones_count == 7) begin
							state <= S_S4;
						end else if (ones_count > 7) begin
							state <= S_S6;
							err <= 1;
						end
					end else begin
						ones_count <= 0;
						state <= S_IDLE;
						disc <= 0;
						flag <= 0;
						err <= 0;
					end
				end
				
				S_S4: begin
					if (in) begin
						ones_count <= ones_count + 1;
						if (ones_count == 7) begin
							state <= S_S5;
						end else if (ones_count > 7) begin
							state <= S_S6;
							err <= 1;
						end
					end else begin
						ones_count <= 0;
						disc <= 1;
						flag <= 1;
						state <= S_IDLE;
					end
				end
				
				S_S5: begin
					if (in) begin
						ones_count <= ones_count + 1;
						if (ones_count == 7) begin
							state <= S_S4;
						end else if (ones_count > 7) begin
							state <= S_S6;
							err <= 1;
						end
					end else begin
						ones_count <= 0;
						state <= S_IDLE;
						disc <= 0;
						flag <= 1;
						err <= 0;
					end
				end
				
				S_S6: begin
					if (in) begin
						ones_count <= ones_count + 1;
					end else begin
						ones_count <= 0;
						state <= S_IDLE;
						disc <= 0;
						flag <= 0;
						err <= 0;
					end
				end
			endcase
		end
	end
endmodule
