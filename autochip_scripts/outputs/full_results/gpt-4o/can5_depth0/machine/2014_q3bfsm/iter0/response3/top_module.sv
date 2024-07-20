module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            A: if (x) next_state = B; else next_state = A;
            B: if (x) next_state = E; else next_state = B;
            C: if (x) next_state = B; else next_state = C;
            D: if (x) next_state = C; else next_state = B;
            E: if (x) next_state = E; else next_state = D;
            default: next_state = A;
        endcase
    end

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        case (state)
            D, E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
