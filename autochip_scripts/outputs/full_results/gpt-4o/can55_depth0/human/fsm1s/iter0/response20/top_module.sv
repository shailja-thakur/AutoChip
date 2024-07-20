module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State declarations
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic: synchronous reset
    always_ff @(posedge clk) begin
        if (reset) 
            state <= B;
        else 
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        case (state)
            B: 
                if (in)
                    next_state = B;
                else
                    next_state = A;
            A: 
                if (in)
                    next_state = A;
                else
                    next_state = B;
            default: 
                next_state = B; // Default state to handle undefined states
        endcase
    end
    
    // Output logic
    always_ff @(posedge clk) begin
        if (reset) 
            out <= 1'b1; // Default output for reset state B
        else begin
            case (state)
                B: out <= 1'b1;
                A: out <= 1'b0;
                default: out <= 1'b1; // Default output for undefined states
            endcase
        end
    end
endmodule
