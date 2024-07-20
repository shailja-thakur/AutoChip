module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA_BITS = 3'd2,
        STOP = 3'd3,
        ERROR = 3'd4
    } state_type;

    state_type state, next_state;
    reg [2:0] bit_counter;  // Counter for data bits

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic
    always_comb begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 0)  // Detect start bit (0)
                    next_state = START;
            end
            START: begin
                if (in == 0)
                    next_state = DATA_BITS;
                else
                    next_state = IDLE;  // False start bit detected
            end
            DATA_BITS: begin
                if (bit_counter == 7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1)  // Detect stop bit (1)
                    next_state = IDLE;
                else
                    next_state = ERROR;  // Error in stop bit
                done = (in == 1);
            end
            ERROR: begin
                if (in == 1)
                    next_state = IDLE;  // Wait for line to go idle
            end
        endcase
    end

    // Data Bit Counter Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            bit_counter <= 0;
        else if (state == DATA_BITS)
            bit_counter <= bit_counter + 1;
        else
            bit_counter <= 0;
    end

endmodule
