module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg state, next_state;
    parameter A = 1'b0, B = 1'b1;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
