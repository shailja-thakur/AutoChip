module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // FSM states
    typedef enum logic [1:0] {
        IDLE = 2'b00,   // Discarding bytes until in[3]=1
        BYTE1 = 2'b01,  // Byte 1 received
        BYTE2 = 2'b10,  // Byte 2 received
        BYTE3 = 2'b11   // Byte 3 received
    } state_t;

    state_t state, next_state;
    logic done_r;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done_r <= 1'b0;
        end else begin
            state <= next_state;
            done_r <= (state == BYTE3); // Signal done in the cycle after third byte of message was received
        end
    end

    always_comb begin
        // Default state transitions
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                // Byte 3 received, go back to IDLE
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
        endcase
    end

    assign done = done_r;

endmodule
