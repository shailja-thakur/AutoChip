module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    // State definitions
    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        READ_DELAY,
        COUNTDOWN,
        WAIT_ACK
    } state_t;
    
    state_t current_state, next_state;

    // Registers to store intermediate values
    reg [2:0] bit_count;
    reg [3:0] delay;
    reg [13:0] cycle_count; // Maximum value will be 9*1000 = 9000 cycles which can fit in 14 bits

    // Pattern detection register
    reg [3:0] pattern;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            pattern <= 4'b0000;
            bit_count <= 3'd0;
            count <= 4'b0000;
            delay <= 4'b0000;
            cycle_count <= 14'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    pattern <= 4'b0000;
                    bit_count <= 3'd0;
                    count <= 4'b0000;
                    delay <= 4'b0000;
                    cycle_count <= 14'd0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                PATTERN_DETECT: begin
                    pattern <= {pattern[2:0], data};
                    bit_count <= bit_count + 1;
                end
                READ_DELAY: begin
                    delay <= {delay[2:0], data};
                    bit_count <= bit_count + 1;
                end
                COUNTDOWN: begin
                    if (cycle_count > 0) begin
                        cycle_count <= cycle_count - 1;
                    end else begin
                        count <= count - 1;
                    end
                end
                WAIT_ACK: begin
                    done <= 1'b1;
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (pattern == 4'b1101) begin
                    next_state = READ_DELAY;
                end else begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (pattern == 4'b1101) begin
                    next_state = READ_DELAY;
                end
            end
            READ_DELAY: begin
                if (bit_count == 3'd3) begin
                    count = delay;
                    cycle_count = 1000; // Start with 1000 cycles for the most significant bit of delay
                    next_state = COUNTDOWN;
                    counting = 1'b1;
                end
            end
            COUNTDOWN: begin
                if (cycle_count == 14'd0) begin
                    if (count == 4'b0000) begin
                        counting = 1'b0;
                        next_state = WAIT_ACK;
                    end else begin
                        count = count - 1;
                        cycle_count = 1000;
                    end
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
