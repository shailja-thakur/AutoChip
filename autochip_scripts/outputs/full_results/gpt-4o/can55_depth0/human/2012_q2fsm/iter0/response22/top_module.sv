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
    
    // State registers
    state_t current_state, next_state;
    
    // State transition table
    always @(*) begin
        case(current_state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A;
        endcase
    end
    
    // State flip-flops
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end
    
endmodule
