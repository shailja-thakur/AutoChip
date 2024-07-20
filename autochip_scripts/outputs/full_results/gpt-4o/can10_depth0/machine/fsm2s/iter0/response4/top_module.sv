module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State declarations
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
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
            default: next_state = STATE_A;  // Default case to avoid latches
        endcase
    end

    // State register update and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            out <= (next_state == STATE_B);
        end
    end

endmodule
