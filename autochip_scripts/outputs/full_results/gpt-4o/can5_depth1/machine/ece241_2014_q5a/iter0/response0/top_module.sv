module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define parameters for the states
    parameter A = 2'b00, B = 2'b01, C = 2'b10;

    // Define a register for the state with an initial value of A
    reg [1:0] state, next_state;

    // Always block triggered on the positive edge of the clock or the reset signal
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Set state to A when reset is triggered
        else
            state <= next_state; // Update state based on next_state
    end

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (x) ? C : A;
            B: next_state = (x) ? B : C;
            C: next_state = (x) ? B : C;
            default: next_state = A; // Default state
        endcase
    end

    // Combinational logic to determine output
    always @(*) begin
        z = (state == C) ? 1 : 0;
    end

endmodule
