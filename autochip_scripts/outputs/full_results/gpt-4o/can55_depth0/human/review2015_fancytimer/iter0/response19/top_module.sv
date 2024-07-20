module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    reg [3:0] state, next_state;
    reg [3:0] pattern_shift, delay, delay_counter;
    reg [13:0] cycle_counter;

    localparam WAIT_PATTERN  = 4'd0,
               LOAD_DELAY    = 4'd1,
               START_COUNT   = 4'd2,
               COUNTING      = 4'd3,
               WAIT_ACK      = 4'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state           <= WAIT_PATTERN;
            pattern_shift   <= 4'd0;
            delay           <= 4'd0;
            counting        <= 1'b0;
            done            <= 1'b0;
            cycle_counter   <= 14'd0;
            delay_counter   <= 4'd0;
        end else begin
            state <= next_state;

            if (next_state == LOAD_DELAY) begin
                delay <= {delay[2:0], data};
            end

            if (next_state == START_COUNT) begin
                cycle_counter <= (delay + 4'd1) * 1000;
                delay_counter <= delay;
                counting      <= 1'b1;
            end

            if (next_state == COUNTING) begin
                if (cycle_counter == 14'd0) begin
                    counting <= 1'b0;
                    done     <= 1'b1;
                end else begin
                    cycle_counter <= cycle_counter - 14'd1;
                    if (cycle_counter % 1000 == 0)
                        delay_counter <= delay_counter - 4'd1;
                end
            end

            if (next_state == WAIT_ACK && ack) begin
                done  <= 1'b0;
            end
        end
    end

    always @* begin
        next_state = state;
        case (state)
            WAIT_PATTERN: begin
                pattern_shift = {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101)
                    next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                if (delay_shift_complete)
                    next_state = START_COUNT;
            end
            START_COUNT: begin
                next_state = COUNTING;
            end
            COUNTING: begin
                if (cycle_counter == 14'd0)
                    next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack)
                    next_state = WAIT_PATTERN;
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'd0;
        else if (counting)
            count <= delay_counter;
    end

endmodule
