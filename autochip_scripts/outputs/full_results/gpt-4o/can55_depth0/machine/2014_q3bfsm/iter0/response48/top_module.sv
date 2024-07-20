module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum reg [2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_D = 3'd3,
        STATE_E = 3'd4
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (x == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                if (x == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_E;
            end
            STATE_C: begin
                if (x == 1'b0)
                    next_state = STATE_C;
                else
                    next_state = STATE_B;
            end
            STATE_D: begin
                if (x == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            end
            STATE_E: begin
                if (x == 1'b0)
                    next_state = STATE_D;
                else
                    next_state = STATE_E;
            end
            default: next_state = STATE_A; // Default case for safety
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 1'b0;
        else begin
            case (current_state)
                STATE_D, STATE_E: z <= 1'b1;
                default: z <= 1'b0;
            endcase
        end
    end

endmodule
