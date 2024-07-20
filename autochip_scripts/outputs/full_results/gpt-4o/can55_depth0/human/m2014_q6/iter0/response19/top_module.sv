module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    typedef enum logic [2:0] {A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (w) ? A : B;
            B: next_state = (w) ? D : C;
            C: next_state = (w) ? D : E;
            D: next_state = (w) ? A : F;
            E: next_state = (w) ? D : E;
            F: next_state = (w) ? D : C;
            default: next_state = A;
        endcase
    end
    
    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
