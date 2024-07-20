module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State Definitions
    localparam A = 1'b0;
    localparam B = 1'b1;
    
    // State Register
    reg state, next_state;

    // State Transition Logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Next State Logic
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

    // Output Logic
    always @(*) begin
        if ((state == A && x == 1'b1) || (state == B && x == 1'b0))
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
