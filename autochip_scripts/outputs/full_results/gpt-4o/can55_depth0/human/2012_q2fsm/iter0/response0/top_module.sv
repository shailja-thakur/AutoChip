module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define state codes
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;

    // State transition always block (State Table)
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (w)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (w)
                    next_state = STATE_C;
                else
                    next_state = STATE_D;
            end
            STATE_C: begin
                if (w)
                    next_state = STATE_E;
                else
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (w)
                    next_state = STATE_F;
                else
                    next_state = STATE_A;
            end
            STATE_E: begin
                if (w)
                    next_state = STATE_E;
                else
                    next_state = STATE_D;
            end
            STATE_F: begin
                if (w)
                    next_state = STATE_C;
                else
                    next_state = STATE_D;
            end
            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops always block
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic (z)
    always @(*) begin
        case (current_state)
            STATE_A, STATE_B, STATE_C, STATE_D: z = 0;
            STATE_E, STATE_F: z = 1;
            default: z = 0;
        endcase
    end

endmodule
