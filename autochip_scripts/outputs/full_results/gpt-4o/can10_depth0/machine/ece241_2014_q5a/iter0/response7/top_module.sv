module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State Encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10;

    // State Register
    reg [1:0] state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            A: next_state = x ? C : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : C;
            default: next_state = A; // Default case for safety
        endcase
    end

    // State Register Update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        z = (state == C);
    end
endmodule
