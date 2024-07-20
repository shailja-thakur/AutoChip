module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'd0,
        READ_PATTERN = 3'd1,
        READ_DELAY = 3'd2,
        COUNTDOWN = 3'd3,
        DONE = 3'd4
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_reg, delay;
    reg [15:0] cycle_counter, delay_counter;
    reg [2:0] bit_counter;

    // State machine
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                next_state = READ_PATTERN;
            end
            READ_PATTERN: begin
                if (shift_reg[3:0] == 4'b1101 && bit_counter == 4) begin
                    next_state = READ_DELAY;
                end
            end
            READ_DELAY: begin
                if (bit_counter == 8) begin
                    next_state = COUNTDOWN;
                end
            end
            COUNTDOWN: begin
                counting = 1;
                if (delay_counter == 0) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Shift Register and Counters
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'd0;
            bit_counter <= 3'd0;
            delay <= 4'd0;
            cycle_counter <= 16'd0;
            delay_counter <= 16'd0;
        end else begin
            case (state)
                IDLE: begin
                    shift_reg <= 4'd0;
                    bit_counter <= 3'd0;
                end
                READ_PATTERN: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (bit_counter < 4) begin
                        bit_counter <= bit_counter + 1;
                    end
                end
                READ_DELAY: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (bit_counter >= 4 && bit_counter < 8) begin
                        delay <= {delay[2:0], data};
                        bit_counter <= bit_counter + 1;
                    end
                end
                COUNTDOWN: begin
                    if (cycle_counter < 1000) begin
                        cycle_counter <= cycle_counter + 1;
                    end else begin
                        cycle_counter <= 16'd0;
                        if (delay_counter > 0) begin
                            delay_counter <= delay_counter - 1;
                        end else begin
                            delay_counter <= delay;
                        end
                    end
                end
                DONE: begin
                    cycle_counter <= 16'd0;
                    delay_counter <= 16'd0;
                end
            endcase
        end
    end

    // Count output logic
    assign count = delay_counter[3:0] - 1;

    // Delay Counter Initialization
    always @(posedge clk) begin
        if (reset || state == READ_DELAY) begin
            cycle_counter <= 16'd0;
            delay_counter <= (delay + 4'd1) * 1000;
        end
    end
endmodule
