module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    typedef enum logic [1:0] {
        S0 = 2'b00,  // Initial state, no bits processed yet
        S1 = 2'b01,  // Processing state, inverting bits
        S2 = 2'b10   // Completion state, bits have been inverted
    } state_t;
    
    state_t state, next_state;
    reg carry;  // Carry bit for the 2's complement operation
    
    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
            carry <= 1'b1;  // Initialize carry to 1 for 2's complement operation
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always @* begin
        case (state)
            S0: begin
                z = 0;
                if (!areset)
                    next_state = S1;
                else
                    next_state = S0;
            end
            
            S1: begin
                z = x ^ carry;
                if (x == 1) begin
                    carry = 0; // Remove carry after first 1 encountered
                end
                next_state = S1;  // Stay in S1 to process all bits
            end
            
            default: begin
                next_state = S0;
                z = 0;
            end
        endcase
    end
endmodule
