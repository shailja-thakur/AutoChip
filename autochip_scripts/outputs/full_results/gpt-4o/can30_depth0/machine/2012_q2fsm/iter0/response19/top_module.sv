module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    // State register
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0) ? A : B;
            B: next_state = (w == 1'b0) ? D : C;
            C: next_state = (w == 1'b0) ? D : E;
            D: next_state = (w == 1'b0) ? A : F;
            E: next_state = (w == 1'b0) ? D : E;
            F: next_state = (w == 1'b0) ? D : C;
            default: next_state = A; // Default state
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
        if (state == E || state == F)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
