module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

    reg state, next_state;

    // State transition
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
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
