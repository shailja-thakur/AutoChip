module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State declaration
    typedef enum reg [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;
    
    // State variable
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b0) ? C : D;
            C: next_state = (w == 1'b0) ? E : D;
            D: next_state = (w == 1'b0) ? F : A;
            E: next_state = (w == 1'b0) ? E : D;
            F: next_state = (w == 1'b0) ? C : D;
            default: next_state = A; // Default case to avoid latches
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
    
    // Output logic
    always @(*) begin
        case (state)
            E: z = 1;
            F: z = 1;
            default: z = 0;
        endcase
    end
    
endmodule
