module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define state codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b00;
parameter F = 2'b01;

// Define state signals
reg [1:0] state;
reg [1:0] next_state;

// Define output signal
reg z;

// State table
always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= A;
	end
	else begin
		state <= next_state;
	end
end

// State flip-flops
always @(state, w) begin
	case (state)
		A: begin
			if (w) begin
				next_state = B;
			end
			else begin
				next_state = A;
			end
		end
		B: begin
			if (w) begin
				next_state = C;
			end
			else begin
				next_state = D;
			end
		end
		C: begin
			if (w) begin
				if (z) begin
					next_state = E;
				end
				else begin
					next_state = C;
				end
			end
			else begin
				next_state = D;
			end
		end
		D: begin
			if (w) begin
				next_state = F;
			end
			else begin
				next_state = A;
			end
		end
		E: begin
			if (w) begin
				if (z) begin
					next_state = E;
				end
				else begin
					next_state = D;
				end
			end
			else begin
				next_state = D;
			end
		end
		F: begin
			if (w) begin
				next_state = C;
			end
			else begin
				next_state = D;
			end
		end
		endcase
end

// Output assignment
always @(state, z) begin
	case (state)
		C, E: z = 1;
		default: z = 0;
	endcase
end

endmodule
