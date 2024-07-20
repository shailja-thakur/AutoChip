module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] timer_count;
    reg [3:0] counter;
    reg [3:0] remainder;
    reg [3:0] next_counter;
    reg [3:0] next_remainder;
    reg [3:0] next_delay;
    reg [3:0] next_timer_count;
    reg [3:0] next_count;
    reg [3:0] current;
    reg [3:0] next_current;
    reg delay_done;
    reg [3:0] initial_counter;
    reg [3:0] initial_remainder;
    reg [3:0] initial_delay;
    reg [3:0] initial_timer_count;
    reg [3:0] initial_count;
    reg initial_current;
    reg start_sequence_detected;
    reg [3:0] count_ack;
    
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay_done <= 0;
            initial_counter <= 0;
            initial_remainder <= 0;
            initial_delay <= 0;
            initial_timer_count <= 0;
            initial_count <= 0;
            initial_current <= 0;
            start_sequence_detected <= 0;
            count_ack <= 0;
        end else begin
            counting <= start_sequence_detected;
            done <= countdown_done;
            delay_done <= countdown_done && ack;
            initial_counter <= next_counter;
            initial_remainder <= next_remainder;
            initial_delay <= next_delay;
            initial_timer_count <= next_timer_count;
            initial_count <= next_count;
            initial_current <= next_current;
            count_ack <= ack;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            next_counter <= initial_counter;
            next_remainder <= initial_remainder;
            next_delay <= initial_delay;
            next_timer_count <= initial_timer_count;
            next_count <= initial_count;
            next_current <= initial_current;
        end else begin
            next_counter <= counter;
            next_remainder <= remainder;
            next_delay <= delay;
            next_timer_count <= timer_count;
            next_count <= count;
            next_current <= current;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            counter <= initial_counter;
            remainder <= initial_remainder;
            delay <= initial_delay;
            timer_count <= initial_timer_count;
            count <= initial_count;
            current <= initial_current;
        end else begin
            counter <= next_counter;
            remainder <= next_remainder;
            delay <= next_delay;
            timer_count <= next_timer_count;
            count <= next_count;
            current <= next_current;
        end
    end

    always @* begin
        if (reset) begin
            next_counter = 4'b0000;
            next_remainder = 4'b0000;
            next_delay = 4'b0000;
            next_timer_count = 4'b0000;
            next_count = 4'b0000;
            next_current = 4'b0000;
        end else if (counter == 4'b0000 && start_sequence_detected) begin
            next_counter = delay;
            next_remainder = delay;
            next_delay = 4'b0000;
            next_timer_count = 4'b0000;
            next_count = 4'b0000;
            next_current = delay;
        end else if (counter != 4'b0000 && remainder != 4'b0000) begin
            next_counter = counter - 4'b0001;
            next_remainder = remainder - 4'b0001;
            next_delay = delay;
            next_timer_count = timer_count;
            next_count = count;
            next_current = current;
        end else if (counter != 4'b0000 && remainder == 4'b0000) begin
            next_counter = counter - 4'b0001;
            next_remainder = delay;
            next_delay = 4'b0000;
            next_timer_count = 4'b0000;
            next_count = 4'b0000;
            if (current != 4'b0000) begin
                next_current = current - 4'b0001;
            end else begin
                next_current = current;
            end
        end else if (counter == 4'b0000 && remainder == 4'b0000) begin
            next_counter = timer_count;
            next_remainder = delay;
            next_delay = 4'b0000;
            next_timer_count = 4'b0000;
            next_count = count + 4'b0001;
            next_current = current;
            if (current == 4'b0000) begin
                done <= 1;
            end
        end
    end

    always @* begin
        if (reset) begin
            start_sequence_detected = 0;
        end else if (start_sequence_detected && !counting) begin
            start_sequence_detected = 0;
        end else if (!start_sequence_detected && data == 1 && $past(data) == 0 && $past($past(data)) == 1 && $past($past($past(data))) == 1) begin
            start_sequence_detected = 1;
        end
    end

    assign count = counting ? current : 4'bxxxx;

endmodule
