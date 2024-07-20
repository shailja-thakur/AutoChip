module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT,
        BYTE_RECEIVED
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        done = 0;

        case (state)
            IDLE:
                if (in == 1)
                    next_state = START_BIT;
            START_BIT:
                if (in == 0)
                    next_state = DATA_BITS;
            DATA_BITS:
                if (in == 0) begin
                    // Process the received data bits here
                    // ...
                    next_state = STOP_BIT;
                end
            STOP_BIT:
                if (in == 1)
                    next_state = BYTE_RECEIVED;
            BYTE_RECEIVED:
                done = 1;
                next_state = IDLE;
        endcase
    end
endmodule
