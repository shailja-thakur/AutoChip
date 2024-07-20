module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack 
    );

    // States
    typedef enum logic [2:0] {
        WAIT_1101,
        LOAD_DELAY,
        COUNTDOWN,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    reg [3:0] delay;
    reg [13:0] timer_count; // to count up to 10000 cycles (enough for (delay+1)*1000 cycles)
    integer bit_counter; // to count 4 bits for the delay value

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= WAIT_1101;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = current_state; // default to stay in the current state
        counting = 0;
        done = 0;

        case (current_state)
            WAIT_1101: begin
                if (data == 1 && bit_counter == 0)
                    bit_counter <= 1;
                else if (data == 1 && bit_counter == 1)
                    bit_counter <= 2;
                else if (data == 0 && bit_counter == 2)
                    bit_counter <= 3;
                else if (data == 1 && bit_counter == 3) begin
                    bit_counter <= 0;
                    next_state = LOAD_DELAY;
                end
            end

            LOAD_DELAY: begin
                counting = 1;
                if (bit_counter < 4) begin
                    delay[3 - bit_counter] <= data;
                    bit_counter = bit_counter + 1;
                end else begin
                    bit_counter = 0;
                    next_state = COUNTDOWN;
                    timer_count = (delay + 1) * 1000 - 1;
                end
            end

            COUNTDOWN: begin
                counting = 1;
                if (timer_count == 0) begin
                    next_state = WAIT_ACK;
                    done = 1;
                end else begin
                    timer_count = timer_count - 1;
                    count = timer_count / 1000;
                end
            end

            WAIT_ACK: begin
                done = 1;
                if (ack) begin
                    next_state = WAIT_1101;
                end
            end
            
            default: begin
                next_state = WAIT_1101;
            end
        endcase
    end

    // Bit counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 0;
        end else if (current_state == WAIT_1101 || current_state == LOAD_DELAY) begin
            bit_counter <= bit_counter;
        end else begin
            bit_counter <= 0;
        end
    end

endmodule
