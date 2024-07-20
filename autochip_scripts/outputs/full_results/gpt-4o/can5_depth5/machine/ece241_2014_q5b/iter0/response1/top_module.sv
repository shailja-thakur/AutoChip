module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
            default: z = 0;
        endcase
    end
endmodule
