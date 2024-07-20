module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    typedef enum reg [2:0] {A, B, C, D, E, F, G, H} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (x) next_state = B; else next_state = A;
            B: if (x) next_state = E; else next_state = B;
            C: if (x) next_state = B; else next_state = C;
            D: if (x) next_state = C; else next_state = B;
            E: if (x) next_state = E; else next_state = D;
            default: next_state = A; // Default case for undefined states
        endcase
    end

    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        z = (state == D || state == E);
    end

endmodule
