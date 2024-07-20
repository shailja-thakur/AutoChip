module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define states using local parameters
    localparam STATE_A = 1'b0, STATE_B = 1'b1;

    // State register
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (j)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: 
                next_state = STATE_A; // default to state A
        endcase
    end

    // State register update and output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A; // Reset state to A
        else
            state <= next_state;
            
        // Output logic
        out <= (state == STATE_B);
    end

endmodule
