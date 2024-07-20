module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE        = 3'b000, // Initial state, searching for 1101
        PATTERN_1   = 3'b001, // Detected first '1'
        PATTERN_11  = 3'b010, // Detected '11'
        PATTERN_110 = 3'b011, // Detected '110'
        PATTERN_1101= 3'b100, // Detected '1101'
        SHIFT       = 3'b101, // Shifting 4 more bits
        COUNTING    = 3'b110, // Waiting for counters
        DONE        = 3'b111  // Timer done, waiting for acknowledgment
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter; // Counter to keep track of 4 shifting cycles

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;

        case(state)
            IDLE: begin
                if (data) // Detected first '1'
                    next_state = PATTERN_1;
            end

            PATTERN_1: begin
                if (!data)
                    next_state = IDLE;
                else
                    next_state = PATTERN_11;
            end

            PATTERN_11: begin
                if (!data)
                    next_state = PATTERN_110;
                else
                    next_state = IDLE;
            end

            PATTERN_110: begin
                if (data)
                    next_state = PATTERN_1101;
                else
                    next_state = IDLE;
            end

            PATTERN_1101: begin
                if (data) // Stay in this state
                    next_state = PATTERN_1101;
                else
                    next_state = SHIFT; // Detected entire pattern
            end

            SHIFT: begin
                shift_ena = 1;
                if (bit_counter == 3'b011)
                    next_state = COUNTING; // Shifted 4 bits
                else
                    next_state = SHIFT;
            end

            COUNTING: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = COUNTING;
            end

            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Output control and bit counter for shift
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 0;
        end
        else if (state == SHIFT) begin
            bit_counter <= bit_counter + 1;
        end
        else begin
            bit_counter <= 0;
        end
    end

endmodule
