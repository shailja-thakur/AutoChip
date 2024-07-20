module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Internal signals
	reg [2:0] state;
	reg z_internal;
	
	// Define the states
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	// Sequential logic
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (w) begin
						state <= A;
					end else begin
						state <= B;
					end
				end
				B: begin
					if (w) begin
						state <= D;
					end else begin
						state <= C;
					end
				end
				C: begin
					if (w) begin
						state <= D;
					end else begin
						state <= E;
					end
				end
				D: begin
					if (w) begin
						state <= A;
					end else begin
						state <= F;
					end
				end
				E: begin
					if (w) begin
						state <= D;
					end else begin
						state <= E;
					end
				end
				F: begin
					if (w) begin
						state <= D;
					end else begin
						state <= C;
					end
				end
			endcase
		end
	end
	
	// Combinational logic
	assign z_internal = (state == E || state == F);
	assign z = z_internal;
  
endmodule
