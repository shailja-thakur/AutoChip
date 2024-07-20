module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE   = 2'b00,
        BYTE1  = 2'b01,
        BYTE2  = 2'b10,
        BYTE3  = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic (next state)
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3])
                    next_state = BYTE1; // First byte of a message
                else
                    next_state = IDLE;  // Stay in IDLE if not valid start byte
            end
            BYTE1: next_state = BYTE2; // Move to BYTE2 after BYTE1
            BYTE2: next_state = BYTE3; // Move to BYTE3 after BYTE2
            BYTE3: next_state = IDLE;  // Move back to IDLE after BYTE3
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        done = 1'b0; // Default value
        if (state == BYTE3)
            done = 1'b1; // Signal done after BYTE3
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= IDLE; // Synchronous reset
        else
            state <= next_state; // Advance state
    end

endmodule
