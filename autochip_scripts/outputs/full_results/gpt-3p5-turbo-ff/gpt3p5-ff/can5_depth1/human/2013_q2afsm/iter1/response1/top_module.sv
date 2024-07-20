module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state_next;
reg [3:1] state;
reg [3:1] g_reg;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

always @(posedge clk) begin
	if(~resetn) begin
		state <= A;
        g_reg <= 3'b000;
	end else begin
		state <= state_next;
        g_reg <= g;
	end
end

always @(*) begin
	case(state)
		A: begin
			if(r[1]==1 && r[2]==1 && r[3]==1)
				state_next = A;
			else if(r[1]==1)
				state_next = B;
			else if(r[1]==0 && r[2]==1)
				state_next = C;
			else if(r[1]==0 && r[2]==0 && r[3]==0)
				state_next = D;
		end
		B: begin
			if(r[1]==1)
				state_next = B;
			else
				state_next = A;
		end
		C: begin
			if(r[2]==1)
				state_next = C;
			else
				state_next = A;
		end
		D: begin
			state_next = A;
		end
	endcase
end

always @(state) begin
	case(state)
		B: g = 3'b001;
		C: g = 3'b010;
		D: g = 3'b100;
		default: g = 3'b000;
	endcase
end

endmodule
