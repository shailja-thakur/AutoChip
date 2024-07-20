module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states using a state encoding (e.g., one-hot encoding)
    typedef enum logic [2:0] {
        IDLE,           // 000
        PATTERN_DETECT, // 001
        SHIFT_4BITS,    // 010
        WAIT_COUNT,     // 011
        DONE            // 100
    } state_t;
    
    state_t state, next_state;
    int [1:0] shift_counter;
    reg [3:0] pattern;
    
    // State Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Pattern detection logic
    always_ff @(posedge clk) begin
        if (state == IDLE) begin
            pattern <= 4'b0;
        end else if (state == PATTERN_DETECT) begin
            pattern <= {pattern[2:0], data};
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default values
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;

        case (state)
            IDLE: begin
                if (pattern == 4'b1101) begin
                    next_state = SHIFT_4BITS;
                end else begin
                    next_state = PATTERN_DETECT;
                end
            end

            PATTERN_DETECT: begin
                if (pattern == 4'b1101) begin
                    next_state = SHIFT_4BITS;
                end else begin
                    next_state = PATTERN_DETECT;
                end
            end

            SHIFT_4BITS: begin
                shift_ena = 1;
                if (shift_counter == 3) begin
                    next_state = WAIT_COUNT;
                end
            end

            WAIT_COUNT: begin
                counting = 1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end

            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Shift Counter
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_counter <= 0;
        end else if (state == SHIFT_4BITS) begin
            if (shift_ena) begin
                shift_counter <= shift_counter + 1;
            end
        end else begin
            shift_counter <= 0;
        end
    end
endmodule
