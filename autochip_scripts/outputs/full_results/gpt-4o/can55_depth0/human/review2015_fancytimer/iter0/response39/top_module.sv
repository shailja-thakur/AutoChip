module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum reg [2:0] { WAIT_PATTERN, SHIFT_DELAY, COUNT_DELAY, WAIT_ACK } state_t;
    state_t state, next_state;

    // Internal registers
    reg [2:0] bit_counter; // To count the bits received
    reg [3:0] delay; // To store the 4-bit delay value
    reg [12:0] cycle_counter; // To count the number of clock cycles

    // Parameters
    localparam IDLE_SEQ = 4'b1101;
    localparam CYCLE_CONST = 1000;

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_PATTERN;
            bit_counter <= 3'b0;
            cycle_counter <= 13'b0;
            delay <= 4'b0;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            WAIT_PATTERN: begin
                counting = 1'b0;
                done = 1'b0;
                if (data == IDLE_SEQ[3-bit_counter]) begin
                    if (bit_counter == 3) begin
                        next_state = SHIFT_DELAY;
                    end else begin
                        next_state = WAIT_PATTERN;
                    end
                end
            end

            SHIFT_DELAY: begin
                delay[3-bit_counter] = data;
                if (bit_counter == 3) begin
                    next_state = COUNT_DELAY;
                end else begin
                    next_state = SHIFT_DELAY;
                end
            end

            COUNT_DELAY: begin
                counting = 1'b1;
                if (cycle_counter < CYCLE_CONST - 1) begin
                    cycle_counter = cycle_counter + 1;
                    next_state = COUNT_DELAY;
                end else begin
                    cycle_counter = 1'b0;
                    count = count - 1;
                    if (count == 0) begin
                        next_state = WAIT_ACK;
                        done = 1'b1;
                        counting = 1'b0;
                    end else begin
                        next_state = COUNT_DELAY;
                    end
                end
            end

            WAIT_ACK: begin
                if (ack) begin
                    next_state = WAIT_PATTERN;
                end
            end

            default: begin
                next_state = WAIT_PATTERN;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            bit_counter <= 3'b0;
        end else begin
            case (state)
                WAIT_PATTERN, SHIFT_DELAY: begin
                    bit_counter <= bit_counter + 1;
                end
                default: begin
                    bit_counter <= 3'b0;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0;
            cycle_counter <= 13'b0;
        end else begin
            case (state)
                COUNT_DELAY: begin
                    if (cycle_counter < CYCLE_CONST - 1) begin
                        cycle_counter <= cycle_counter + 1;
                    end else begin
                        cycle_counter <= 13'b0;
                        count <= count - 1;
                    end
                end
                default: begin
                    cycle_counter <= 13'b0;
                end
            endcase
        end
    end

    always @(*) begin
        if (state == COUNT_DELAY) begin
            count = delay;
        end
    end
endmodule
