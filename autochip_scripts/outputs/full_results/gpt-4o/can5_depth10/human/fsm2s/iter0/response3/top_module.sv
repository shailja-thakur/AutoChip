module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
); 
    // State Encoding
    typedef enum logic [1:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;
    
    state_t current_state, next_state;

    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= OFF;
        else
            current_state <= next_state;
    end

    // Next State Logic
    always_comb begin
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
            default: 
                next_state = OFF; 
        endcase
    end

    // Output Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b0;
        else
            out <= (current_state == ON);
    end
endmodule
