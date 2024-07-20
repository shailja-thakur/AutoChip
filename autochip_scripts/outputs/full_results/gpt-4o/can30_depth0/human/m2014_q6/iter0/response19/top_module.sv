module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State Encoding
    typedef enum logic [2:0] {
        A = 3'b000, // State A
        B = 3'b001, // State B
        C = 3'b010, // State C
        D = 3'b011, // State D
        E = 3'b100, // State E
        F = 3'b101  // State F
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            A: if (w) next_state = A; else next_state = B;
            B: if (w) next_state = D; else next_state = C;
            C: if (w) next_state = D; else next_state = E;
            D: if (w) next_state = A; else next_state = F;
            E: if (w) next_state = D; else next_state = E;
            F: if (w) next_state = D; else next_state = C;
            default: next_state = A;
        endcase
    end

    // State Flip-Flops
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output Logic
    always @(*) begin
        case (state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end
endmodule
