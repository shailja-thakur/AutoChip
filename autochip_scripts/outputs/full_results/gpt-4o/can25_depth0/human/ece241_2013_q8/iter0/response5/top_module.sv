module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,   // Initial state
        S1 = 2'b01,   // State when '1' is detected
        S2 = 2'b10    // State when '10' is detected
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @ (*) begin
        case (state)
            S0: begin
                if (x == 1) 
                    next_state = S1;
                else 
                    next_state = S0;
            end
            
            S1: begin
                if (x == 0)
                    next_state = S2;
                else 
                    next_state = S1;
            end
            
            S2: begin
                if (x == 1)
                    next_state = S1;
                else 
                    next_state = S0;
            end
            
            default: next_state = S0;
        endcase
    end
    
    // Output logic
    always @ (*) begin
        z = 1'b0;
        if (state == S2 && x == 1)
            z = 1'b1;
    end
    
    // State register with asynchronous reset
    always @ (negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end
    
endmodule
