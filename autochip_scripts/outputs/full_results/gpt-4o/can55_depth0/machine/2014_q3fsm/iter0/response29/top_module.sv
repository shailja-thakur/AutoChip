module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encoding
    typedef enum reg [3:0] {
        A = 4'd0,
        B = 4'd1,
        C = 4'd2,
        S10 = 4'd3,
        S11 = 4'd4,
        S20 = 4'd5,
        S21 = 4'd6,
        S22 = 4'd7
    } state_t;
    
    state_t state, next_state;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;  // Initial state
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
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
            
            S20: begin
                next_state = B;
            end
            
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
            
            default: begin
                next_state = A;
            end
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 1'b0;
        end else begin
            z <= (state == S20 || state == S21 || state == S22);
        end
    end
endmodule
