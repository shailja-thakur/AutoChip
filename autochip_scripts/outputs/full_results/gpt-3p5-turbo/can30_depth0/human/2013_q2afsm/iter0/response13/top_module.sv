module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// State codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state_reg;
reg [1:0] state_next;
reg [3:1] g_reg;
reg [3:1] g_next;

// State table
always @(state_reg or r)
begin
	case(state_reg)
		A: begin
			if (r[1] & ~r[2] & ~r[3])
         	 	state_next = B;
            else if (r[1] & ~r[2] & r[3])
                state_next = C;
            else if (~r[1] & ~r[2] & ~r[3])
                state_next = D;
            else
                state_next = A;
		end
		B: begin
			if (r[1] & ~r[2])
                state_next = B;
            else if (r[1] & ~r[2])
                state_next = A;
            else
                state_next = B;
		end
		C: begin
			if (r[2] & ~r[1])
                state_next = C;
            else if (r[2] & ~r[1])
                state_next = A;
            else
                state_next = C;
		end
		D: begin
			if (r[1] & ~r[2] & ~r[3])
                state_next = A;
            else
                state_next = D;
		end
	endcase
end

// State flip-flops
always @(posedge clk or negedge resetn)
begin
	if (~resetn)
	begin
		state_reg <= A;
		g_reg <= 3'b000;
	end
	else
	begin
		state_reg <= state_next;
		g_reg <= g_next;
	end
end

// FSM outputs
always @(state_reg)
begin
	case(state_reg)
		A: g_next = 3'b000;
		B: g_next = (r[1] & g_reg[1]) ? 3'b010 : 3'b000;
		C: g_next = (r[2] & g_reg[2]) ? 3'b001 : 3'b000;
		D: g_next = (r[3] & ~r[1] & ~r[2] & g_reg[3]) ? 3'b100 : 3'b000;
	endcase
end

// Output assignment
assign g = g_reg;

endmodule
