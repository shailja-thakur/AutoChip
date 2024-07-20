module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define state codes
parameter A = 3'b000; // state A
parameter B = 3'b001; // state B
parameter C = 3'b010; // state C
parameter D = 3'b011; // state D
parameter E = 3'b100; // state E
parameter F = 3'b101; // state F

// Define state flip-flops
reg [2:0] current_state;
reg [2:0] next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= A;
	end else begin
		current_state <= next_state;
	end
end

// State table
always @(current_state or w) begin
	case (current_state)
		A: begin
			if (w) begin
				next_state <= B;
			end else begin
				next_state <= A;
			end
		end
		B: begin
			if (w) begin
				next_state <= C;
			end else begin
				next_state <= D;
			end
		end
		C: begin
			if (w) begin
				next_state <= E;
			end else begin
				next_state <= D;
			end
		end
		D: begin
			if (w) begin
				next_state <= F;
			end else begin
				next_state <= A;
			end
		end
		E: begin
			if (w) begin
				next_state <= E;
			end else begin
				next_state <= D;
			end
		end
		F: begin
			if (w) begin
				next_state <= C;
			end else begin
				next_state <= D;
			end
		end
		default: next_state <= A;
	endcase
end

// Output assignment
always @(current_state) begin
	case (current_state)
		E: z <= 1;
		default: z <= 0;
	endcase
end

endmodule
