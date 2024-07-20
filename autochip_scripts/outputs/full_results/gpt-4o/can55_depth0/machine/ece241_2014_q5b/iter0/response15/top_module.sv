module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State declaration
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // Combinational logic for output
    always @(*) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
