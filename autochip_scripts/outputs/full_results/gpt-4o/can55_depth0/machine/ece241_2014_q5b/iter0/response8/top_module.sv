module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State declarations
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // State and output register logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            z <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                A: z <= x;
                B: z <= ~x;
                default: z <= 1'b0;
            endcase
        end
    end

endmodule
