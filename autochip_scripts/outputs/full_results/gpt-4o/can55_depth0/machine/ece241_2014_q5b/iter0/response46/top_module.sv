module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Declare state parameters
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                // In state A, transition to B if x is 1, otherwise stay in A
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                // In state B, stay in B
                next_state = B;
            end
            default: begin
                next_state = A; // Default case to handle all other scenarios
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        if ((state == A && x) || (state == B && !x))
            z = 1;
        else
            z = 0;
    end

endmodule
