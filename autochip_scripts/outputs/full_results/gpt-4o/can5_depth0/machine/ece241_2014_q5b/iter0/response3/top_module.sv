module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State definitions
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if ((state == A && x) || (state == B && ~x))
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
