module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg {A, B} state_t;
    
    // Declare state registers
    state_t current_state, next_state;
    
    // Output logic: out is high when in state B, low when in state A
    always @(current_state) begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A; // Set state to A when reset is high
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
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
            default: next_state = A;
        endcase
    end

endmodule
