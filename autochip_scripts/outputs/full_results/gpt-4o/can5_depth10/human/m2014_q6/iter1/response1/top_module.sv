module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic - combinational logic
    always @(*) begin
        case (state)
            A: next_state = (w) ? A : B;
            B: next_state = (w) ? D : C;
            C: next_state = (w) ? D : E;
            D: next_state = (w) ? A : F;
            E: next_state = (w) ? D : E;
            F: next_state = (w) ? D : C;
            default: next_state = A; // Default state
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic based on state - combination logic is updated after a state transition
    always @(*) begin
        case (state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end
endmodule
