module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j) 
                    next_state = ON;
                else 
                    next_state = OFF;
            end
            ON: begin
                if (k) 
                    next_state = OFF;
                else 
                    next_state = ON;
            end
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
            out <= 0;
        else begin
            case (state)
                OFF: out <= 0;
                ON: out <= 1;
                default: out <= 0;
            endcase
        end
    end

endmodule
