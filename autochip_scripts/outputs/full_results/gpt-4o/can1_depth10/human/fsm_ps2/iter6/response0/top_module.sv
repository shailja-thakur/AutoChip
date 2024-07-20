module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always @* begin
        next_state = state; // Default to stay in current state
        done = 1'b0; // Default to done being low
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = IDLE;
                done = 1'b1; // Signal done in the cycle immediately after the third byte is received
            end
            default: next_state = IDLE; // To handle unexpected scenarios
        endcase
    end

endmodule
