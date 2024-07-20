module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg [1:0] {
        STATE_B = 2'b00,
        STATE_A = 2'b01
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_B;
        endcase
    end
    
    // State register logic
    always @(posedge clk) begin
        if (reset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 1'b1; // Default output value for reset state
        else begin
            case (state)
                STATE_B: out <= 1'b1;
                STATE_A: out <= 1'b0;
                default: out <= 1'b1;
            endcase
        end
    end

endmodule
