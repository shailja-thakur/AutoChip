module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state;  // register to store the current state
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 3'b000;  // set state to A when resetn is low
		end else begin
			case (state)
				3'b000: begin  // current state is A
					if (r[1]) begin
						state <= 3'b001;  // next state is B if r[1] is high
					end else if (r[2]) begin
						state <= 3'b010;  // next state is C if r[2] is high
					end else if (r[3]) begin
						state <= 3'b011;  // next state is D if r[3] is high
					end else begin
						state <= 3'b000;  // next state is A if none of the bits are high
					end
				end
				
				3'b001: begin  // current state is B
					if (r[1]) begin
						state <= 3'b001;  // next state is B if r[1] is high
					end else begin
						state <= 3'b000;  // next state is A if r[1] is low
					end
				end
				
				3'b010: begin  // current state is C
					if (r[2]) begin
						state <= 3'b010;  // next state is C if r[2] is high
					end else begin
						state <= 3'b000;  // next state is A if r[2] is low
					end
				end
				
				3'b011: begin  // current state is D
					if (r[3]) begin
						state <= 3'b011;  // next state is D if r[3] is high
					end else begin
						state <= 3'b000;  // next state is A if r[3] is low
					end
				end
			endcase
		end
	end
	
	assign g[1] = (state == 3'b001) ? 1'b1 : 1'b0;  // g[1] is high if current state is B
	assign g[2] = (state == 3'b010) ? 1'b1 : 1'b0;  // g[2] is high if current state is C
	assign g[3] = (state == 3'b011) ? 1'b1 : 1'b0;  // g[3] is high if current state is D
	
endmodule
