module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State definitions
    typedef enum reg [2:0] {
        IDLE,         // Waiting for start sequence
        READ_DELAY,   // Reading the 4-bit delay value
        COUNTING,     // Counting for the delay period
        DONE          // Waiting for user acknowledgment
    } state_t;
    
    state_t state, next_state;
    reg [3:0] pattern_shift;
    reg [3:0] delay;
    reg [12:0] counter;  // 13-bit counter to count up to (2^4 * 1000) - 1
    reg [3:0] remaining_time;

    assign count = (state == COUNTING) ? remaining_time : 4'bxxxx;

    // State transition logic
    always @ (posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // State machine logic
    always @ (*) begin
        next_state = state;  // Default next state is the current state
        case (state)
            IDLE: begin
                counting = 0;
                done = 0;
                if (pattern_shift == 4'b1101) begin
                    next_state = READ_DELAY;
                end
            end
            READ_DELAY: begin
                if (delay != 4'bxxxx) begin
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                counting = 1;
                if (counter == 0) begin
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

    // Shift register for detecting pattern and reading delay
    always @ (posedge clk) begin
        if (reset || state == DONE) begin
            pattern_shift <= 4'b0000;
        end else if (state == IDLE || (state == READ_DELAY && pattern_shift != 4'b1111)) begin
            pattern_shift <= {pattern_shift[2:0], data};
        end else if (state == READ_DELAY) begin
            delay <= {delay[2:0], data};
        end
    end

    // Counter logic
    always @ (posedge clk) begin
        if (reset || state == DONE) begin
            counter <= 0;
            remaining_time <= 0;
        end else if (state == COUNTING) begin
            if (counter == 0) begin
                if (remaining_time == 0) begin
                    counter <= 0;
                end else begin
                    remaining_time <= remaining_time - 1;
                    counter <= 1000 - 1;
                end
            end else begin
                counter <= counter - 1;
            end
        end else if (state == READ_DELAY) begin
            counter <= (delay + 1) * 1000 - 1;
            remaining_time <= delay;
        end
    end

endmodule
