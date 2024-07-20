module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State Encoding
    typedef enum reg [1:0] {
        S0 = 2'b00, // initial state
        S1 = 2'b01, // state after seeing '1'
        S2 = 2'b10  // state after seeing '10'
    } state_t;
    
    state_t current_state, next_state;
    
    // Sequential Block - State Transition
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            current_state <= S0; // reset to initial state
        else
            current_state <= next_state;
    end
    
    // Combinational Block - Next State Logic
    always @(*) begin
        case (current_state)
            S0: 
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            S1: 
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            S2: 
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            default: 
                next_state = S0; 
        endcase
    end
    
    // Combinational Block - Output Logic
    always @(*) begin
        case (current_state)
            S0: z = 0;
            S1: z = 0;
            S2: z = x ? 1 : 0;
            default: z = 0;
        endcase
    end
   
endmodule
