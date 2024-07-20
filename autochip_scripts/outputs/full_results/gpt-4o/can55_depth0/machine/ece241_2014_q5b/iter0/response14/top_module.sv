module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State definition
    parameter A = 1'b0, B = 1'b1;
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

    // State flip-flops (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) z = 1;
               else z = 0;
            B: if (~x) z = 1;
               else z = 0;
            default: z = 0;
        endcase
    end

endmodule
