module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define states
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    // State transition on clock edge
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Next state logic
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
            default:
                next_state = OFF;
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 0;
        else
            case (state)
                OFF: out <= 0;
                ON: out <= 1;
                default: out <= 0;
            endcase
    end
endmodule
