module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;
    
    state_t state, next_state;
    
    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end
    
    // State transition table
    always @(*) begin
        case (state)
            A:    next_state = (w) ? B : A;
            B:    next_state = (w) ? C : D;
            C:    next_state = (w) ? E : D;
            D:    next_state = (w) ? F : A;
            E:    next_state = (w) ? E : D;
            F:    next_state = (w) ? C : D;
            default: next_state = A;
        endcase
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
