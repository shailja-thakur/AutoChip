module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: if (j) next_state = B; else next_state = A;
            B: if (k) next_state = A; else next_state = B;
            default: next_state = A;
        endcase
    end
    
    // State and output update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            out <= 1'b0;
        end else begin
            state <= next_state;
            out <= (next_state == B) ? 1'b1 : 1'b0;
        end
    end
    
endmodule
