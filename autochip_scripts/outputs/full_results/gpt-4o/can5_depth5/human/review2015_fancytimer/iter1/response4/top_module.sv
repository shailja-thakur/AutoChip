module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNT_DELAY,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    reg [3:0] delay; // To store the delay value
    reg [9:0] cycle_counter; // To count the 1000 clock cycles
    reg [3:0] shift_reg; // Shift register to detect the pattern and load delay
    reg [2:0] bit_counter; // To count the number of bits shifted in after pattern detection
    reg [3:0] delay_temp; // Temporary storage for delay

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 0;
        counting = 0;

        case (current_state)
            // Initial state to detect the pattern 1101
            IDLE: begin
                if (shift_reg == 4'b1101)
                    next_state = LOAD_DELAY;
            end

            // Load the delay value
            LOAD_DELAY: begin
                if (bit_counter == 4)
                    next_state = COUNT_DELAY;
            end

            // Count for the specified delay
            COUNT_DELAY: begin
                counting = 1;
                if (cycle_counter == 0 && delay == 0)
                    next_state = WAIT_ACK;
            end

            // Wait for user acknowledgment
            WAIT_ACK: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Synchronous logic for shift register, bit counter, delay and cycle counter
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 0;
            bit_counter <= 0;
            count <= 'bx; // Don't-care state
            cycle_counter <= 0;
            delay <= 0;
            delay_temp <= 0;
        end else begin
            // Operation inside states
            case (current_state)
                IDLE: begin
                    shift_reg <= {shift_reg[2:0], data}; // Shift in data bits
                    if (shift_reg == 4'b1101)
                        bit_counter <= 0;
                end

                LOAD_DELAY: begin
                    delay_temp <= {delay_temp[2:0], data}; // Shift in the delay bits
                    bit_counter <= bit_counter + 1;
                    if (bit_counter == 3) begin // After shifting 4 bits
                        delay <= {delay_temp[2:0], data};
                        count <= {delay_temp[2:0], data}; // Set count as delay for initial counting
                        cycle_counter <= 999; // Set counter for 1000 cycles
                    end
                end

                COUNT_DELAY: begin
                    counting <= 1;
                    if (cycle_counter == 0) begin
                        if (delay != 0) begin
                            delay <= delay - 1;
                            count <= delay - 1;
                            cycle_counter <= 999;
                        end else begin
                            counting <= 0;
                        end
                    end else begin
                        cycle_counter <= cycle_counter - 1;
                    end
                end

                WAIT_ACK: begin
                    if (ack) begin
                        shift_reg <= 0;
                        bit_counter <= 0;
                        cycle_counter <= 0;
                        delay <= 0;
                        delay_temp <= 0;
                    end
                end
            endcase
        end
    end

endmodule
