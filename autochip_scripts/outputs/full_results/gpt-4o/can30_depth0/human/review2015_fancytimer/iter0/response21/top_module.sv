module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        PATTERN_DETECT = 3'd1,
        LOAD_DELAY = 3'd2,
        COUNT = 3'd3,
        WAIT_ACK = 3'd4
    } state_t;

    state_t state, next_state;

    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [12:0] timer_count; // 13 bits for counting up to 8000 clock cycles

    // Sequential block for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Combinational block for next state logic and outputs
    always @(*) begin
        // Default outputs
        next_state = state;
        shift_reg = shift_reg;
        delay = delay;
        timer_count = timer_count;
        counting = 0;
        done = 0;

        case(state)
            IDLE: begin
                if (data) begin
                    next_state = PATTERN_DETECT;
                    shift_reg = 4'b0001;
                end
            end
            PATTERN_DETECT: begin
                shift_reg = {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end else begin
                    next_state = IDLE;
                end
            end
            LOAD_DELAY: begin
                shift_reg = {shift_reg[2:0], data};
                if (count == 4) begin
                    delay = {shift_reg[2:0], data};
                    timer_count = (delay + 1) * 1000;
                    next_state = COUNT;
                end else begin
                    count = count + 1;
                end
                // Reset the shift count
                shift_reg = 0;
            end
            COUNT: begin
                counting = 1;
                if (timer_count > 0) begin
                    timer_count = timer_count - 1;
                    count = timer_count[12:10]; // Extract the msb of remaining time.
                end else begin
                    next_state = WAIT_ACK;
                    done = 1;
                end
            end
            WAIT_ACK: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Timer count logic
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (state == COUNT) begin
            if (timer_count[9:0] == 10'd999) begin
                count <= count - 1;
            end
        end
    end
endmodule
