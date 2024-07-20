module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    // State register
    state_t state, next_state;
    
    // State transition
    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0) ? A : B;
            B: next_state = (w == 1'b0) ? D : C;
            C: next_state = (w == 1'b0) ? D : E;
            D: next_state = (w == 1'b0) ? A : F;
            E: next_state = (w == 1'b0) ? D : E;
            F: next_state = (w == 1'b0) ? D : C;
            default: next_state = A; // Default to initial state
        endcase
    end
    
    // Output logic
    always @(*) begin
        z = (state == E || state == F) ? 1'b1 : 1'b0;
    end

endmodule
