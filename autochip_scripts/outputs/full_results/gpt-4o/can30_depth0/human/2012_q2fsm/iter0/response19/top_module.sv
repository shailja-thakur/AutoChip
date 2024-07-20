module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    state_t current_state, next_state;

    // State flip-flops (state register)
    always @(posedge clk) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // State table (next-state logic)
    always @(*) begin
        case (current_state)
            A: if (w) next_state = B;
               else next_state = A;
            B: if (w) next_state = C;
               else next_state = D;
            C: if (w) next_state = E;
               else next_state = D;
            D: if (w) next_state = F;
               else next_state = A;
            E: if (w) next_state = E;
               else next_state = D;
            F: if (w) next_state = C;
               else next_state = D;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A, B, C, D: z = 0;
            E, F: z = 1;
            default: z = 0;
        endcase
    end

endmodule
