module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A  = 3'b000,
        STATE_B  = 3'b001,
        STATE_C  = 3'b010,
        STATE_S10 = 3'b011,
        STATE_S11 = 3'b100,
        STATE_S20 = 3'b101,
        STATE_S21 = 3'b110,
        STATE_S22 = 3'b111
    } state_t;

    state_t state, next_state;

    // Sequential logic: state transitions
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Combinational logic: next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (w)
                    next_state = STATE_S11;
                else
                    next_state = STATE_S10;
            end
            STATE_C: begin
                if (w)
                    next_state = STATE_S11;
                else
                    next_state = STATE_S10;
            end
            STATE_S10: begin
                if (w)
                    next_state = STATE_S21;
                else
                    next_state = STATE_S20;
            end
            STATE_S11: begin
                if (w)
                    next_state = STATE_S22;
                else
                    next_state = STATE_S21;
            end
            STATE_S20: begin
                next_state = STATE_B;
            end
            STATE_S21: begin
                if (w)
                    next_state = STATE_C;
                else
                    next_state = STATE_B;
            end
            STATE_S22: begin
                if (w)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic associated with the states
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 0;
        else begin
            case (state)
                STATE_S10, STATE_S11, STATE_S20, STATE_S21, STATE_S22: z <= 1;
                default: z <= 0;
            endcase
        end
    end

endmodule
