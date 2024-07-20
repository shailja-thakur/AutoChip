module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State declaration
    typedef enum reg [2:0] {
        A, B, C, S10, S11, S20, S21, S22
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition always block
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end

            B: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            end
            
            C: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            end
            
            S10: begin
                if (w)
                    next_state = S21;
                else
                    next_state = S20;
            end
            
            S11: begin
                if (w)
                    next_state = S22;
                else
                    next_state = S21;
            end
            
            S20: next_state = B;
            
            S21: begin
                if (w)
                    next_state = C;
                else
                    next_state = B;
            end
            
            S22: begin
                if (w)
                    next_state = B;
                else
                    next_state = C;
            end
            
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            S22: z = 1; // 'z' output is 1 only in state S22
            default: z = 0;
        endcase
    end

endmodule
