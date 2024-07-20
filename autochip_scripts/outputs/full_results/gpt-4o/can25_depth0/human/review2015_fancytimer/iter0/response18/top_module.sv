module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [2:0] state, next_state;
    reg [3:0] delay;
    reg [3:0] bit_counter;
    reg [15:0] cycle_counter;
    reg [3:0] remaining_time;

    parameter WAIT_PATTERN = 3'b000,
              READ_DELAY    = 3'b001,
              COUNTING      = 3'b010,
              DONE          = 3'b011;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state          <= WAIT_PATTERN;
            counting       <= 0;
            done           <= 0;
            delay          <= 0;
            bit_counter    <= 0;
            cycle_counter  <= 0;
            remaining_time <= 0;
        end else begin
            state <= next_state;

            if (state == WAIT_PATTERN) begin
                if (data == 1) bit_counter <= bit_counter + 1;
                else bit_counter <= 0;

                if (bit_counter == 3) delay[3] <= data;
                if (bit_counter == 4) delay[2] <= data;
                if (bit_counter == 5) delay[1] <= data;
                if (bit_counter == 6) delay[0] <= data;
            end else if (state == READ_DELAY) begin
                bit_counter <= bit_counter + 1;
            end else if (state == COUNTING) begin
                if (cycle_counter == 999) begin
                    cycle_counter <= 0;
                    remaining_time <= remaining_time - 1;
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end else if (state == DONE) begin
                if (ack) begin
                    bit_counter <= 0;
                    cycle_counter <= 0;
                    remaining_time <= 0;
                end
            end
        end
    end

    always @(*) begin
        case (state)
            WAIT_PATTERN: begin
                counting = 0;
                done = 0;
                if (bit_counter == 6) next_state = READ_DELAY;
                else next_state = WAIT_PATTERN;
            end
            READ_DELAY: begin
                if (bit_counter < 10) next_state = READ_DELAY;
                else begin
                    next_state = COUNTING;
                    remaining_time = delay;
                end
            end
            COUNTING: begin
                counting = 1;
                if (remaining_time == 0 && cycle_counter == 999) begin
                    counting = 0;
                    done = 1;
                    next_state = DONE;
                end else begin
                    next_state = COUNTING;
                end
            end
            DONE: begin
                if (ack) next_state = WAIT_PATTERN;
                else next_state = DONE;
            end
            default: next_state = WAIT_PATTERN;
        endcase
    end

    assign count = counting ? remaining_time : 4'bXXXX;

endmodule
