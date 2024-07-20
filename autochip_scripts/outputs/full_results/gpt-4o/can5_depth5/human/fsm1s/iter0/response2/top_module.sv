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

    // State transition
    always @(*) begin
        case (state)
            STATE_B: if (in == 1'b0)
                        next_state = STATE_A;
                     else
                        next_state = STATE_B;
            STATE_A: if (in == 1'b0)
                        next_state = STATE_B;
                     else
                        next_state = STATE_A;
            default: next_state = STATE_B; // default state
        endcase
    end

    // Update state on rising edge of clock or reset
    always @(posedge clk) begin
        if (reset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 1'b1; // As STATE_B is reset state
        else begin
            case (next_state)
                STATE_B: out <= 1'b1;
                STATE_A: out <= 1'b0;
            endcase
        end
    end
endmodule
