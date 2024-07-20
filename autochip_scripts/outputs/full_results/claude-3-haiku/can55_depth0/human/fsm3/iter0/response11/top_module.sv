module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// Define the state variables
reg [1:0] state, next_state;

// Define the state assignments
localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

// Next state logic
always @(*) begin
    case (state)
        A: next_state = (in) ? B : A;
        B: next_state = (in) ? B : C;
        C: next_state = (in) ? D : A;
        D: next_state = (in) ? B : C;
        default: next_state = A; // default case to avoid latches
    endcase
end

// Output logic
always @(*) begin
    case (state)
        D: out = 1'b1;
        default: out = 1'b0;
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

endmodule
