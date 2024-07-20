module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define states
parameter A = 2'b00;  // Define state A as 00 in binary
parameter B = 2'b01;  // Define state B as 01 in binary
parameter C = 2'b10;  // Define state C as 10 in binary
parameter D = 2'b11;  // Define state D as 11 in binary

// Define current state and next state registers
reg [1:0] current_state;
reg [1:0] next_state;

// Define output register
reg out_reg;

// Update next state based on current state and input
always @(*) begin
    case (current_state)
        A: begin
            if (in == 1'b0)
                next_state = A;
            else if (in == 1'b1)
                next_state = B;
        end
        B: begin
            if (in == 1'b0)
                next_state = C;
            else if (in == 1'b1)
                next_state = B;
        end
        C: begin
            if (in == 1'b0)
                next_state = A;
            else if (in == 1'b1)
                next_state = D;
        end
        D: begin
            if (in == 1'b0)
                next_state = C;
            else if (in == 1'b1)
                next_state = B;
        end
        default: next_state = A;
    endcase
end

// Update current state with next state on positive edge of clk
always @(posedge clk or posedge reset) begin
    if (reset == 1'b1)
        current_state <= A;
    else
        current_state <= next_state;
end

// Assign output based on current state
always @(current_state) begin
    case (current_state)
        A: out_reg = 1'b0;
        D: out_reg = 1'b1;
        default: out_reg = 1'b0;
    endcase
end

// Assign output to output port
assign out = out_reg;

endmodule
