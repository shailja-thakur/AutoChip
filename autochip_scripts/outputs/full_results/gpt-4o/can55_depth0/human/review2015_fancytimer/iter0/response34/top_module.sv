module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    parameter IDLE = 0, DETECT_1101 = 1, LOAD_DELAY = 2, COUNT = 3, DONE = 4;
    reg [2:0] state, next_state;
    reg [3:0] delay;
    reg [12:0] cycle_counter;
    reg [3:0] remaining_time;
    reg [3:0] pattern_buffer;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern_buffer <= 4'b0000;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    pattern_buffer <= {pattern_buffer[2:0], data};
                end
                DETECT_1101: begin
                    pattern_buffer <= 4'b0000;
                end
                LOAD_DELAY: begin
                    delay <= {delay[2:0], data};
                end
                COUNT: begin
                    if (cycle_counter == 0) begin
                        if (remaining_time > 0) begin
                            remaining_time <= remaining_time - 1;
                            cycle_counter <= 999;
                        end else begin
                            remaining_time <= 0;
                            cycle_counter <= 0;
                        end
                    end else begin
                        cycle_counter <= cycle_counter - 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        pattern_buffer <= 4'b0000;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state;
        counting = 0;
        done = 0;
        count = 4'b0000;

        case (state)
            IDLE: begin
                if (pattern_buffer == 4'b1101) begin
                    next_state = DETECT_1101;
                end
            end
            DETECT_1101: begin
                next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                if (delay[3:0] == 4'b1111) begin
                    next_state = COUNT;
                    remaining_time = delay;
                    cycle_counter = (delay + 1) * 1000 - 1;
                end
            end
            COUNT: begin
                counting = 1;
                count = remaining_time;
                if (cycle_counter == 0 && remaining_time == 0) begin
                    next_state = DONE;
                    done = 1;
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

endmodule
