module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State declaration
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    state_t state, next_state;
    
    // State transition always block
    always @(*) begin
        case (state)
            A: if (w) next_state = B; else next_state = A;
            B: if (w) next_state = C; else next_state = D;
            C: if (w) next_state = E; else next_state = D;
            D: if (w) next_state = F; else next_state = A;
            E: if (w) next_state = E; else next_state = D;
            F: if (w) next_state = C; else next_state = D;
            default: next_state = A; // default case to avoid latches
        endcase
    end
    
    // State flip-flops
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = 0;
            B: z = 0;
            C: z = 0;
            D: z = 0;
            E: z = 1;
            F: z = 1;
            default: z = 0;
        endcase
    end
endmodule
