module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State enumeration
    typedef enum logic [1:0] {
        ZERO = 2'b00,     // State where value of input is 0
        ONE = 2'b01,      // State where value of input is 1
        ADD_ONE = 2'b10   // State to add one for 2's complement
    } state_t;
    
    state_t current_state, next_state;

    // Combinatorial state transition logic
    always @(*) begin
        case (current_state)
            ZERO: 
                if (x)
                    next_state = ADD_ONE;
                else
                    next_state = ZERO;

            ONE: 
                next_state = ONE;
                
            ADD_ONE: 
                next_state = ONE;
                
            default: 
                next_state = ZERO;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            ZERO: z = x;         // Simply propagate the input bit
            ONE: z = ~x;         // Flip the input bit
            ADD_ONE: z = ~x + 1; // Invert and add 1
            default: z = 0;      // Default case, should not happen
        endcase
    end

    // Sequential state transition
    always @(posedge clk or posedge areset) begin
        if (areset) 
            current_state <= ZERO;
        else 
            current_state <= next_state;
    end

endmodule
