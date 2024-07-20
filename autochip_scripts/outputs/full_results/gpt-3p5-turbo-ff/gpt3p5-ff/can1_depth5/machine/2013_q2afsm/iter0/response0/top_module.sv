module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
	reg state, next;
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			state <= next;
		end
	end

	always @(*) begin
		case (state)
			A: begin
				if (r[1]) begin
					next = B;
				end else if (r[2]) begin
					next = C;
				end else if (r[3]) begin
					next = D;
				end else begin
					next = A;
				end
			end

			B: begin
				if (r[1]) begin
					next = B;
				end else begin
					next = A;
				end
			end

			C: begin
				if (r[2]) begin
					next = C;
				end else begin
					next = A;
				end
			end

			D: begin
				if (r[3]) begin
					next = D;
				end else begin
					next = A;
				end
			end
		endcase
	end

	assign g[1] = (state == B) ? 1'b1 : 1'b0;
	assign g[2] = (state == C) ? 1'b1 : 1'b0;
	assign g[3] = (state == D) ? 1'b1 : 1'b0;
endmodule
