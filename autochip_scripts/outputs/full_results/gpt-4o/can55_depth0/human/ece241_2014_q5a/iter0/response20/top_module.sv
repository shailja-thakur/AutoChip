module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] { S0, S1, S2, S3 } state_t;
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: begin
                // Reset state, waiting for LSB
                z = x; // Directly output the input
                next_state = x ? S2 : S1;
            end
            S1: begin
                // State for the non-complementing part (input is 0)
                z = x; // Directly output the input
                next_state = x ? S2 : S1;
            end
            S2: begin
                // State for the complementing part (input is 1)
                z = ~x; // Output complement of input
                next_state = x ? S2 : S1;
            end
            default: begin
                // Default state handles explicitly S3 and other states
                z = 1'bx; // Undefined, should not occur
                next_state = S0; // Reset to initial state
            end
        endcase
    end

endmodule
