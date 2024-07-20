module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    // Define state encoding
    typedef enum reg [0:0] {
        OFF = 1'b0,
        ON = 1'b1
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
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
            default: next_state = OFF;
        endcase
    end
    
    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 1'b0;
        else
            out <= (state == ON) ? 1'b1 : 1'b0;
    end

endmodule
