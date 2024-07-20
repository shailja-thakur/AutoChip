module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state_next;
reg [3:1] state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

always @(posedge clk or negedge resetn) begin
	if(~resetn) begin
		state <= A;
	end else begin
		state <= state_next;
	end
end

always @(*) begin
	case(state)
		A: begin
			if(r[1]==1 && r[2]==1 && r[3]==1) begin
				state_next = A;
			end else if(r[1]==1) begin
				state_next = B;
			end else if(r[1]==0 && r[2]==1) begin
				state_next = C;
			end else if(r[1]==0 && r[2]==0 && r[3]==0) begin
				state_next = D;
			end
		end
		B: begin
			if(r[1]==1) begin
				state_next = B;
			end else begin
				state_next = A;
			end
		end
		C: begin
			if(r[2]==1) begin
				state_next = C;
			end else begin
				state_next = A;
			end
		end
		D: begin
			state_next = A;
		end
	endcase
end

always @(posedge clk) begin
	if(resetn == 1'b0) begin
		g <= 0;
	end else begin
		case(state)
			A: begin
				g <= 3'b000;
			end
			B: begin
				g <= 3'b001;
			end
			C: begin
				g <= 3'b010;
			end
			D: begin
				g <= 3'b011;
			end
		endcase
	end
end

endmodule
