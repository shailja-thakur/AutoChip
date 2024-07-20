module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Parameter to define the states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Register to hold the current state
    reg state, next_state;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
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
            default: begin
                next_state = A;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 0;
        endcase
    end

endmodule
