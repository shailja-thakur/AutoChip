module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State parameters
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (x == 1'b1) 
                    next_state = B;
               else
                    next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if ((state == A && x == 1'b1) || (state == B && x == 1'b0))
            z = 1'b1;
        else
            z = 1'b0;
    end
endmodule
