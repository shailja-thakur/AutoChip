module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [2:0] state_reg;
reg [2:0] state_next;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

assign g[1] = (state_reg == B || state_reg == D);
assign g[2] = (state_reg == C || state_reg == D);
assign g[3] = (state_reg == D);

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state_reg <= A;
	end else begin
		state_reg <= state_next;
	end
end

always @(state_reg, r) begin
	case (state_reg)
		A: begin
			if (r[1]) begin
				state_next = B;
			end else if (r[2]) begin
				state_next = C;
			end else if (r[3]) begin
				state_next = D;
			end else begin
				state_next = A;
			end
		end
		
		B: begin
			if (r[1]) begin
				state_next = B;
			end else begin
				state_next = A;
			end
		end
		
		C: begin
			if (r[2]) begin
				state_next = C;
			end else begin
				state_next = A;
			end
		end
		
		D: begin
			if (r[1] || r[2] || r[3]) begin
				state_next = D;
			end else begin
				state_next = A;
			end
		end
	endcase
end
endmodule
