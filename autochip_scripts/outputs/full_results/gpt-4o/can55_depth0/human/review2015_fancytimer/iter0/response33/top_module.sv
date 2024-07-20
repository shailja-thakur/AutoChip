module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [3:0] state, next_state;
    reg [3:0] delay, next_delay;
    reg [9:0] counter, next_counter;
    reg [3:0] countdown, next_countdown;
    reg [4:0] shift_count, next_shift_count;
    reg [3:0] start_pattern; // 4-bit shift register to match 1101

    localparam IDLE = 4'd0,
               READ_DELAY = 4'd1,
               COUNT = 4'd2,
               DONE = 4'd3;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            delay <= 4'd0;
            counter <= 10'd0;
            countdown <= 4'd0;
            shift_count <= 5'd0;
            start_pattern <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            delay <= next_delay;
            counter <= next_counter;
            countdown <= next_countdown;
            shift_count <= next_shift_count;
            start_pattern <= {start_pattern[2:0], data}; // Shift in new data bit for pattern detection
            counting <= (next_state == COUNT);
            done <= (next_state == DONE);
        end
    end

    always @* begin
        next_state = state;
        next_delay = delay;
        next_counter = counter;
        next_countdown = countdown;
        next_shift_count = shift_count;

        case (state)
            IDLE: begin
                // Look for start pattern 1101
                if (start_pattern == 4'b1101) begin
                    next_state = READ_DELAY;
                    next_shift_count = 0;
                end
            end
            READ_DELAY: begin
                // Shift in 4 more bits for the delay value
                next_shift_count = shift_count + 1;
                if (shift_count < 4) begin
                    next_delay = {delay[2:0], data};
                end else begin
                    next_state = COUNT;
                    next_counter = (delay + 1) * 1000;
                    next_countdown = delay;
                end
            end
            COUNT: begin
                // Wait for counter to expire
                if (counter > 0) begin
                    next_counter = counter - 1;
                end else if (countdown > 0) begin
                    next_countdown = countdown - 1;
                    next_counter = 1000;
                end else begin
                    next_state = DONE;
                end
            end
            DONE: begin
                // Wait for acknowledgement
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    assign count = (state == COUNT) ? countdown : 4'hx;

endmodule
