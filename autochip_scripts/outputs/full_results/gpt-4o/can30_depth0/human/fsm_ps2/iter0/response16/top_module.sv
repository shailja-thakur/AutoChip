module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // FSM state encoding
    typedef enum logic [1:0] {
        IDLE  = 2'b00, // Waiting for the first byte with in[3]=1
        BYTE2 = 2'b01, // Received the first byte, waiting for the second byte
        BYTE3 = 2'b10  // Received the second byte, waiting for the third byte
    } state_t;

    state_t state, next_state;

    // Next-state logic
    always @(*) begin
        // Default values
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE2;
                end
            end

            BYTE2: begin
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = IDLE;
                done = 1'b1; // Signal done in the cycle immediately after 3rd byte
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // State flip-flops and reset logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

endmodule
