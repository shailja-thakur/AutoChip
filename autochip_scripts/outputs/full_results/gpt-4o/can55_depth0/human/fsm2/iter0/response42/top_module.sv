module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define state encoding
    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;
    
    // Declare state registers
    state_t state, next_state;
    
    // Asynchronous reset and state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic based on current state and inputs
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1'b1)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            
            ON: begin
                if (k == 1'b1)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            
            default: next_state = OFF; // Default state is OFF
        endcase
    end
    
    // Output logic based on the current state
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0; // Default to OFF output
        endcase
    end

endmodule
