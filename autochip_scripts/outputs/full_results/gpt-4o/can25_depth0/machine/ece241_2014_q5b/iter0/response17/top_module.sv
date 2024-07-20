module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (x) 
                    next_state = B;
                else 
                    next_state = A;
            B: next_state = B;
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
        if ((state == A && x == 1) || (state == B && x == 0))
            z = 1;
        else
            z = 0;
    end

endmodule
