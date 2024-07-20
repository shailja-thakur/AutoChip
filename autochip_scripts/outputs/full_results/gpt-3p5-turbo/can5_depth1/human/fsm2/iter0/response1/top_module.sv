module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    // Define states
    typedef enum logic [1:0] {
        OFF,
        ON
    } state_type;
    
    // Define state and next_state registers
    reg state_type state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            state <= OFF;
        end else begin
            // Sequential logic
            state <= next_state;
        end
    end
    
    always @* begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
                out = 0;  // Output is 0 when state is OFF
            end
            
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
                out = 1;  // Output is 1 when state is ON
            end
        endcase
    end
endmodule
