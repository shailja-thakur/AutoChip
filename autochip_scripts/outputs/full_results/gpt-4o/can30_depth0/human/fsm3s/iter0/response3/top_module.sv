module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State Encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always @(*) begin
        case (current_state)
            STATE_A: if (in) next_state = STATE_B; else next_state = STATE_A;
            STATE_B: if (in) next_state = STATE_B; else next_state = STATE_C;
            STATE_C: if (in) next_state = STATE_D; else next_state = STATE_A;
            STATE_D: if (in) next_state = STATE_B; else next_state = STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // State Register Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output Logic (Moore FSM: Output depends only on the state)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            case (current_state)
                STATE_A: out <= 1'b0;
                STATE_B: out <= 1'b0;
                STATE_C: out <= 1'b0;
                STATE_D: out <= 1'b1;
                default: out <= 1'b0;
            endcase
        end
    end

endmodule
