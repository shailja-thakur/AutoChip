module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
    );

    typedef enum logic [2:0] {
        WAIT_PATTERN,
        READ_DELAY,
        COUNTING,
        TIMER_DONE
    } state_t;

    state_t current_state, next_state;

    reg [3:0] bit_counter;
    reg [3:0] delay;
    reg [11:0] delay_counter;
    reg [13:0] total_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= WAIT_PATTERN;
            bit_counter <= 4'h0;
            delay <= 4'h0;
            delay_counter <= 12'h0;
            total_counter <= 14'h0;
            count <= 4'h0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            WAIT_PATTERN: begin
                if (data == 1'b1 && bit_counter == 4'hC) begin
                    next_state = READ_DELAY;
                end
            end
            READ_DELAY: begin
                if (bit_counter == 4'h3) begin
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                if (total_counter == (delay + 1) * 1000 - 1) begin
                    next_state = TIMER_DONE;
                end
            end
            TIMER_DONE: begin
                if (ack) begin
                    next_state = WAIT_PATTERN;
                end
            end
        endcase
    end

    // Output logic and internal register updates
    always_ff @(posedge clk) begin
        case (current_state)
            WAIT_PATTERN: begin
                done <= 1'b0;
                counting <= 1'b0;
                if (data == 1'b1) begin
                    bit_counter <= bit_counter + 1;
                end else if (data == 1'b0 && bit_counter == 4'hC) begin
                    bit_counter <= 4'h0;
                end
            end
            READ_DELAY: begin
                counting <= 1'b0;
                delay[3 - bit_counter] <= data;
                bit_counter <= bit_counter + 1;
            end
            COUNTING: begin
                counting <= 1'b1;
                total_counter <= total_counter + 1;
                delay_counter <= (delay_counter == 999) ? 12'h0 : delay_counter + 1;
                if (delay_counter == 999) begin
                    count <= count - 1;
                end
            end
            TIMER_DONE: begin
                counting <= 1'b0;
                done <= 1'b1;
                if (ack) begin
                    delay <= 4'h0;
                    total_counter <= 14'h0;
                    count <= 4'h0;
                end
            end
        endcase
    end

endmodule
