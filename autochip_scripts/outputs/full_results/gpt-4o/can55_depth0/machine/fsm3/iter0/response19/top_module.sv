module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define state encoding
localparam A = 2'b00;
localparam B = 2'b01;
localparam C = 2'b10;
localparam D = 2'b11;

// State register
reg [1:0] state, next_state;

// Sequential logic for state transitions
always @(posedge clk or posedge areset) begin
	if (areset) 
        state <= A; // Reset to state A
	else 
        state <= next_state; // Move to the next state on clock edge
end

// Combinational logic for next state determination
always @(*) begin
    case (state)
        A: next_state = in ? B : A;
        B: next_state = in ? B : C;
        C: next_state = in ? D : A;
        D: next_state = in ? B : C;
        default: next_state = A; // Default to state A
    endcase
end

// Output logic
assign out = (state == D);

endmodule
