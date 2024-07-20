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
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;  // Initialize to state A on reset
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (j) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (k) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            default: begin
                next_state = A;  // default state
            end
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            out <= (state == B);
        end
    end
    
endmodule
