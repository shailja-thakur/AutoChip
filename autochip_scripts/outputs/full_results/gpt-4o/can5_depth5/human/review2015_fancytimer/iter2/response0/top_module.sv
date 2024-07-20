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

    // State Machine for Transition
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // State Machine for combinational logic
    always @(*) begin
        next_state = current_state;
        done = 0;
        counting = 0;
        count = 4'b1111; // don't care

        case (current_state)
            IDLE: begin
                if (shift_reg == 4'b1101)
                    next_state = LOAD_DELAY;
                else
                    next_state = IDLE;
            end
            PATTERN_DETECT: begin
                if (shift_reg == 4'b1101)
                    next_state = LOAD_DELAY;
                else
                    next_state = PATTERN_DETECT;
            end
            LOAD_DELAY: begin
                if (bit_counter == 3) 
                    next_state = COUNT_DELAY;
                else
                    next_state = LOAD_DELAY;
            end
            COUNT_DELAY: begin
                counting = 1;
                count = delay; // Output the current remaining time
                if (cycle_counter == 0) begin
                    if (delay == 0)
                        next_state = WAIT_ACK;
                    else
                        next_state = COUNT_DELAY;
                end else
                    next_state = COUNT_DELAY;
            end
            WAIT_ACK: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end
        endcase
    end

    // State Machine for Output and Counter Logic
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 0;
            bit_counter <= 0;
            cycle_counter <= 1000;
            delay <= 0;
        end else begin
            case (current_state)
                IDLE: begin
                    shift_reg <= {shift_reg[2:0], data}; // Shift in data bits
                    bit_counter <= 0;
                end
                PATTERN_DETECT: begin
                    shift_reg <= {shift_reg[2:0], data}; // Shift in data bits
                end
                LOAD_DELAY: begin
                    if (bit_counter < 4) begin
                        delay <= {delay[2:0], data}; // Shift in the delay bits
                        bit_counter <= bit_counter + 1;
                    end
                    if (bit_counter == 4) begin
                        cycle_counter <= 1000; // Initialize cycle counter
                    end
                end
                COUNT_DELAY: begin
                    counting <= 1;
                    count <= delay; // Output the current remaining time
                    if (cycle_counter == 0) begin
                        if (delay > 0) begin
                            delay <= delay - 1;
                            count <= delay - 1;
                            cycle_counter <= 999;
                        end else begin
                            counting <= 0;
                            done <= 1;
                        end
                    end else begin
                        cycle_counter <= cycle_counter - 1;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        done <= 0;
                        counting <= 0;
                        shift_reg <= 0;
                        bit_counter <= 0;
                        cycle_counter <= 1000;
                        delay <= 0;
                        count <= 4'b1111; // Reset count to don't care state
                    end
                end
            endcase
        end
    end
    
endmodule
