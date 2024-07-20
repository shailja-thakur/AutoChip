module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000, // Waiting for start bit
        START   = 3'b001, // Start bit detected
        RECEIVE = 3'b010, // Receiving data bits
        CHECK_STOP = 3'b011, // Checking stop bit
        DONE    = 3'b100, // Byte correctly received
        ERROR   = 3'b101  // Error state
    } state_t;

    state_t state, next_state;
    integer bit_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
        end else begin
            state <= next_state;
            if (next_state == RECEIVE) begin
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 0;
            end
        end
    end

    always_comb begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (!in) begin // Detecting start bit (0)
                    next_state = START;
                end
            end
            START: begin
                next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 7) begin
                    next_state = CHECK_STOP;
                end
            end
            CHECK_STOP: begin
                if (in) begin // Correct stop bit (1)
                    next_state = DONE;
                end else begin
                    next_state = ERROR; // Error: stop bit incorrect
                end
            end
            DONE: begin
                done = 1;
                if (!in) begin // Start bit detected for next byte
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            ERROR: begin
                if (in) begin // Waiting for stop bit to reset error
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
