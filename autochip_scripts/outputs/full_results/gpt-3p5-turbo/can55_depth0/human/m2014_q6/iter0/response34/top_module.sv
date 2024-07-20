module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define states
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;
	
	// Define state register
	reg [2:0] state;
	reg [2:0] next_state;
	
	// Define outputs
	reg out_z;
	assign z = out_z;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
			out_z <= 0;
		end
		else begin
			state <= next_state;
			case (state)
				A: begin
					if (w) begin
						next_state <= A;
					end
					else begin
						next_state <= B;
					end
					out_z <= 0;
				end
				B: begin
					if (w) begin
						next_state <= D;
					end
					else begin
						next_state <= C;
					end
					out_z <= 0;
				end
				C: begin
					if (w) begin
						next_state <= D;
					end
					else begin
						next_state <= E;
					end
					out_z <= 0;
				end
				D: begin
					if (w) begin
						next_state <= A;
					end
					else begin
						next_state <= F;
					end
					out_z <= 0;
				end
				E: begin
					if (w) begin
						next_state <= D;
					end
					else begin
						next_state <= E;
					end
					out_z <= 1;
				end
				F: begin
					if (w) begin
						next_state <= D;
					end
					else begin
						next_state <= C;
					end
					out_z <= 1;
				end
				default: begin
					next_state <= A;
					out_z <= 0;
				end
			endcase
		end
	end
endmodule
