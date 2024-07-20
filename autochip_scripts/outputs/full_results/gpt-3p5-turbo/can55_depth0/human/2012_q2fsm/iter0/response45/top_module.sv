module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

// Define the state register and the next state register
reg [1:0] state_reg, state_next;

// State transition logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= A;
	end else begin
		state_reg <= state_next;
	end
end

// State transition logic
always @* begin
	case(state_reg)
		A: begin
			if(w) begin
				state_next = B;
			end else begin
				state_next = A;
			end
		end
		B: begin
			if(w) begin
				state_next = C;
			end else begin
				state_next = D;
			end
		end
		C: begin
			if(w) begin
				state_next = E;
			end else begin
				state_next = D;
			end
		end
		D: begin
			if(w) begin
				state_next = F;
			end else begin
				state_next = A;
			end
		end
		E: begin
			if(w) begin
				state_next = E;
			end else begin
				state_next = D;
			end
		end
		F: begin
			if(w) begin
				state_next = C;
			end else begin
				state_next = D;
			end
		end
	endcase
end

// Output assignment
always @* begin
	case(state_reg)
		A, B, C: z = 0;
		D, E, F: z = 1;
	endcase
end

endmodule
