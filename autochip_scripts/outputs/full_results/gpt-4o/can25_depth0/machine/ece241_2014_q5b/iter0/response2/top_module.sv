module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state, next_state;

    // Next state logic
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
        endcase
    end

    // State transition logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign z = (state == A && x) || (state == B && !x);

endmodule
