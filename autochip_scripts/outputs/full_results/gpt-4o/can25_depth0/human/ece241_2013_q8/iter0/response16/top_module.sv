module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0,  // Initial state
        S1,  // State after receiving '1'
        S2   // State after receiving '10'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*)
    begin
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

    // State register
    always @(negedge aresetn or posedge clk)
    begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(posedge clk or negedge aresetn)
    begin
        if (!aresetn)
            z <= 1'b0;
        else
        begin
            case (current_state)
                S0: z <= 1'b0;
                S1: z <= 1'b0;
                S2: z <= (x == 1'b1); // Output 'z' is asserted when current state is S2 and input 'x' is 1
                default: z <= 1'b0;
            endcase
        end
    end

endmodule
