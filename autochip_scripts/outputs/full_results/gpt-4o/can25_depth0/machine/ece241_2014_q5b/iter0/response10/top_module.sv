module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {A, B} state_t;
    state_t state, next_state;

    // State transition logic (next state logic)
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end

    // State register (sequential logic)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
            default: z = 0;
        endcase
    end

endmodule
