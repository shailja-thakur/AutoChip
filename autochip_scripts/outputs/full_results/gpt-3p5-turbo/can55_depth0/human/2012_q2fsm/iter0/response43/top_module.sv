module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define states
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// Declare internal signals
reg [2:0] current_state;
reg [2:0] next_state;

// Define state table
always @(current_state or w)
begin
	case (current_state)
		A: if (w) begin next_state = B; end else begin next_state = A; end
		B: if (w) begin next_state = C; end else begin next_state = D; end
		C: if (w) begin next_state = E; end else begin next_state = D; end
		D: if (w) begin next_state = F; end else begin next_state = A; end
		E: if (!w) begin next_state = D; end else begin next_state = E; end
		F: if (!w) begin next_state = D; end else begin next_state = C; end
		default: next_state = A;
	endcase
end

// Update state
always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
		current_state <= A;
	end
	else
	begin
		current_state <= next_state;
	end
end

// Output assignment
always @(current_state)
begin
	case (current_state)
		E, F: z = 1'b1;
		default: z = 1'b0;
	endcase
end

endmodule
