module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    parameter A = 0, B = 1;
    reg state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            A: z = x ? 1 : 0;
            B: z = 0;
            default: z = 0;
        endcase
    end

endmodule
