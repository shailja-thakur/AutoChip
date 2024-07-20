module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    localparam IDLE = 3'b000,
               PATTERN = 3'b001,
               LOAD_DELAY = 3'b010,
               COUNTDOWN = 3'b011,
               DONE = 3'b100;

    reg [2:0] state, next_state;
    reg [3:0] delay, next_delay;
    reg [15:0] counter, next_counter;
    reg [2:0] bits_received, next_bits_received;
    reg [3:0] next_count;
    reg [3:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'b0;
            counter <= 16'b0;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            bits_received <= 3'b0;
            shift_reg <= 4'b0;
        end else begin
            state <= next_state;
            delay <= next_delay;
            counter <= next_counter;
            count <= next_count;
            bits_received <= next_bits_received;
            shift_reg <= {shift_reg[2:0], data};
        end
    end

    always @(*) begin
        next_state = state;
        next_delay = delay;
        next_counter = counter;
        next_bits_received = bits_received;
        next_count = count;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state = PATTERN;
                    next_bits_received = 3'b0;
                end
            end
            PATTERN: begin
                if (bits_received < 3) begin
                    next_delay = {delay[2:0], data};
                    next_bits_received = bits_received + 1;
                end else begin
                    next_delay = {delay[2:0], data};
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                next_counter = (delay + 1) * 1000;
                next_count = delay;
                next_state = COUNTDOWN;
            end
            COUNTDOWN: begin
                counting = 1'b1;
                if (counter > 0) begin
                    next_counter = counter - 1;
                    if ((counter % 1000) == 0) begin
                        next_count = next_count - 1;
                    end
                end else begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                    next_delay = 4'b0;
                    next_counter = 16'b0;
                    next_count = 4'b0;
                    next_bits_received = 3'b0;
                end
            end
        endcase
    end
endmodule
