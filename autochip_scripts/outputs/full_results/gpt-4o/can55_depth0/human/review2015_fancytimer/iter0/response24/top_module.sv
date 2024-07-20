module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack);

    // State declaration
    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT_DELAY,
        COUNT_DELAY,
        WAIT_ACK
    } state_t;
    state_t state, next_state;

    // FSM registers and wires
    reg [3:0] delay;
    reg [15:0] counter;
    reg [3:0] bit_count;

    // State Transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'd0;
            counter <= 16'd0;
            bit_count <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default values for output signals
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    bit_count = bit_count + 1;
                end
                if (bit_count == 4 && data == 1'b1) begin
                    next_state = PATTERN_DETECT;
                    bit_count = 4'd0;
                end
            end

            PATTERN_DETECT: begin
                if (data == 1'b1) begin
                    bit_count = bit_count + 1;
                end
                
                if (bit_count == 4 && data == 1'b1) begin
                    next_state = SHIFT_DELAY;
                    bit_count = 4'd0;
                end
            end

            SHIFT_DELAY: begin
                if (bit_count < 4) begin
                    delay[3 - bit_count] = data;
                    bit_count = bit_count + 1;
                end
                else begin
                    next_state = COUNT_DELAY;
                    counter = (delay + 1) * 1000;
                end
            end

            COUNT_DELAY: begin
                counting = 1'b1;
                if (counter > 0) begin
                    counter = counter - 1;
                end
                else begin
                    next_state = WAIT_ACK;
                end
            end

            WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output the current remaining time
    always_ff @(posedge clk) begin
        if (state == COUNT_DELAY) begin
            count <= counter / 1000;
        end
        else begin
            count <= 4'd0;
        end
    end
endmodule
