module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
wire [3:1] grant;

// Define states
parameter A = 3'd1;
parameter B = 3'd2;
parameter C = 3'd3;
parameter D = 3'd4;

// Define state outputs
assign g[1] = (state == B) ? 1'b1 : 1'b0;
assign g[2] = (state == C) ? 1'b1 : 1'b0;
assign g[3] = (state == D) ? 1'b1 : 1'b0;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(state, r) begin
	case (state)
		A: begin
			if (r[1]) begin // Detect r1 request
				next_state = (r[2]) ? C : B; // Check for additional r2 request
			end else if(r[2]) begin // Detect r2 request
				next_state = B;
			end else if(r[3]) begin // Detect r3 request
				next_state = D;
			end else begin
				next_state = A;
			end
		end
		B: begin
			if (r[1]) begin // Detect r1 request
				next_state = B;
			end else if(~r[1]) begin // Detect r1 request
				next_state = A;
			end
		end
		C: begin
			if (r[2]) begin // Detect r2 request
				next_state = C;
			end else if(~r[2]) begin // Detect r2 request
				next_state = A;
			end
		end
		D: begin
			if (r[1] || r[2] || r[3]) begin // Detect any request
				next_state = D;
			end else begin
				next_state = A;
			end
		end
	endcase
end

endmodule
