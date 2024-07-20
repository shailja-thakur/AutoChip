module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = 1'b0;
            default: z = 1'b0;
        endcase
    end

endmodule
