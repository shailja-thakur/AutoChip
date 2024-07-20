module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [1:0] state, next_state;
    reg [2:0] bit_count;
    reg [3:0] delay, delay_counter;
    reg [9:0] cycle_counter;

    localparam IDLE = 2'b00, WAIT_DELAY = 2'b01, COUNTING = 2'b10, DONE = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            delay <= 0;
            delay_counter <= 0;
            cycle_counter <= 0;
            counting <= 0;
            done <= 0;
            count <= 4'bxxxx; // Don't care when not counting
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
                if (data) begin
                    if (bit_count == 3 && delay == 4'b0001) begin
                        next_state = WAIT_DELAY;
                        bit_count = 0;
                    end else begin
                        delay = {delay[2:0], data};
                        bit_count = bit_count + 1;
                    end
                end
            end
            WAIT_DELAY: begin
                delay = {delay[2:0], data};
                bit_count = bit_count + 1;
                if (bit_count == 3) begin
                    next_state = COUNTING;
                    cycle_counter = 0;
                    delay_counter = delay;
                end
            end
            COUNTING: begin
                counting = 1;
                if (cycle_counter == 999) begin
                    if (delay_counter == 0) begin
                        next_state = DONE;
                    end else begin
                        delay_counter = delay_counter - 1;
                        cycle_counter = 0;
                    end
                end else begin
                    cycle_counter = cycle_counter + 1;
                end
                count = delay_counter;
            end
            DONE: begin
                done = 1;
                counting = 0;
                if (ack) begin
                    next_state = IDLE;
                    bit_count = 0;
                    delay = 0;
                end
            end
        endcase
    end
endmodule
