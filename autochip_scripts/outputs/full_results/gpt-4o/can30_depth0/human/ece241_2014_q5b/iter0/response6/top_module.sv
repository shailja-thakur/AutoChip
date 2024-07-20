module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // State encoding using one-hot encoding
    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t state, next_state;

    // Output logic based on current state and input
    always_comb begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 1'b0;
        endcase
    end

    // State transition logic
    always_comb begin
        case (state)
            A: next_state = (x) ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
