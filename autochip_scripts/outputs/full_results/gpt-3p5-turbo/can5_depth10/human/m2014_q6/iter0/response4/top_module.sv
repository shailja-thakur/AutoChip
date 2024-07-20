module top_module (
	input wire clk,
	input wire reset,
	input wire w,
	output wire z
);

// Define state names
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

// Define state signals
reg [2:0] state;
wire [2:0] next_state;

// Define output signal
reg z_reg;
wire z_next;

always @(posedge clk, negedge reset) begin
	if (reset == 0) begin
		state <= A;
		z_reg <= 0;
	end
	else begin
		state <= next_state;
		z_reg <= z_next;
	end
end

always @(state or w) begin
	case (state)
		A: begin
			if (w)
				next_state = A;
			else
				next_state = B;
		end
		B: begin
			if (w)
				next_state = D;
			else
				next_state = C;
		end
		C: begin
			if (w)
				next_state = D;
			else
				next_state = E;
		end
		D: begin
			if (w)
				next_state = A;
			else
				next_state = F;
		end
		E: begin
			if (w)
				next_state = D;
			else
				next_state = E;
		end
		F: begin
			if (w)
				next_state = D;
			else
				next_state = C;
		end
	endcase
end

assign z_next = (state == E || state == F);

assign z = z_reg;

endmodule
