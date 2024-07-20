module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define state parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10;

    // Register to hold the current state
    reg [1:0] state, next_state;

    // Always block for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (x) ? C : A;
            B: next_state = (x) ? B : C;
            C: next_state = (x) ? B : C;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        z = (state == C) ? 1'b1 : 1'b0;
    end

endmodule
