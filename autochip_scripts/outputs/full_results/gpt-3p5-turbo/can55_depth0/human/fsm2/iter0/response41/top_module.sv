module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output wire out
);

    // Define state enumeration
    typedef enum logic [1:0] {OFF, ON} state_type;
    
    // Define state and next state signals
    reg state_type current_state;
    reg state_type next_state;
    
    // Define output reg
    reg out_reg;
    
    // Define asynchronous reset
    always @(posedge clk or posedge areset)
        if (areset)
            current_state <= OFF;
        else
            current_state <= next_state;
    
    // Define next state logic
    always @(current_state, j, k)
        case (current_state)
            OFF:
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            ON:
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
        endcase
    
    // Define output logic
    always @(current_state)
        case (current_state)
            OFF:
                out_reg = 0;
            ON:
                out_reg = 1;
        endcase
    
    // Assign output
    assign out = out_reg;
    
endmodule
