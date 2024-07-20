module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Parameters for the states
    parameter A = 1'b0, B = 1'b1;

    // Register to hold the current state
    reg state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Asynchronous reset
        else
            state <= next_state; // State transition
    end

    // Combinational logic for state transition
    always @(*) begin
        case (state)
            A: if (x)
                   next_state = B;
               else
                   next_state = A;
            B: next_state = B;
            default: next_state = A;
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
