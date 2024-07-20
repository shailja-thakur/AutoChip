module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    typedef enum logic [1:0] {
        IDLE,    // Waiting for the first byte with in[3] = 1
        BYTE1,   // First byte received
        BYTE2,   // Second byte received
        BYTE3    // Third byte received
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        done = 0;
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                done = 1;
                next_state = IDLE;
            end
        endcase
    end

endmodule
