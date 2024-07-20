module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Parameter definitions for states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;

    // Register to hold the current state
    reg [1:0] state, next_state;

    // Always block for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset state
        else
            state <= next_state; // Move to next state
    end

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (x) ? C : A; // From A to C if x is true
            B: next_state = (x) ? B : C; // From B to B if x is true, else to C
            C: next_state = (x) ? B : C; // From C to B if x is true, else stay in C
            default: next_state = A; // Default state
        endcase
    end

    // Combinational logic for output z
    always @(*) begin
        z = (state == C); // z is true if state is C, otherwise false
    end

endmodule
