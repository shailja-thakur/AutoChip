module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [3:1] state_reg, state_next;
wire [2:0] g_temp;

// Define states
parameter A = 3'b001;
parameter B = 3'b010;
parameter C = 3'b011;
parameter D = 3'b100;

// Define output assignments for g signals
assign g_temp[0] = (state_reg == B) && (r[1] == 1'b1);
assign g_temp[1] = (state_reg == C) && (r[2] == 1'b1);

// Sequential logic for state transition
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state_reg <= A;
	end else begin
		state_reg <= state_next;
	end
end

// Combinational logic for next state and output assignments
always @(state_reg, r) begin
	case(state_reg)
		A: begin
			if (r[1] == 1'b1) begin
				if (r[2] == 1'b1) begin
					if (r[3] == 1'b1) begin
						state_next = D;
					end else begin
						state_next = C;
					end
				end else if (r[3] == 1'b1) begin
					state_next = B;
				end else begin
					state_next = A;
				end
			end else if (r[2] == 1'b1) begin
				if (r[3] == 1'b1) begin
					state_next = B;
				end else begin
					state_next = A;
				end
			end else if (r[3] == 1'b1) begin
				state_next = D;
			end else begin
				state_next = A;
			end
		end
		B: begin
			if ((r[1] == 1'b0) && (g_temp[0] == 1'b0)) begin
				state_next = A;
			end else begin
				state_next = B;
			end
		end
		C: begin
			if ((r[2] == 1'b0) && (g_temp[1] == 1'b0)) begin
				state_next = A;
			end else begin
				state_next = C;
			end
		end
		D: begin
			state_next = A;
		end
	endcase
end

// Assign g outputs
assign g[0] = (state_reg == B) && (r[1] == 1'b1);
assign g[1] = (state_reg == C) && (r[2] == 1'b1);
assign g[2] = 1'b0;

endmodule
