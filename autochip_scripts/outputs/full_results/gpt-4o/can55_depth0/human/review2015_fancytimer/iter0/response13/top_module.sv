module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack 
);

    typedef enum reg [2:0] {
        WAIT_FOR_PATTERN,
        READ_DELAY,
        COUNT_DOWN,
        TIMER_DONE
    } state_t;

    state_t state, next_state;

    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [12:0] counter; // 13 bits to count up to 8191

    // State transition logic
    always @ (posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_PATTERN;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @ (*) begin
        case (state)
            WAIT_FOR_PATTERN: begin
                done = 1'b0;
                counting = 1'b0;
                next_state = WAIT_FOR_PATTERN;
                if ({shift_reg[2:0], data} == 4'b1101) begin
                    next_state = READ_DELAY;
                end
            end

            READ_DELAY: begin
                next_state = READ_DELAY;
                if (shift_reg[3] == 1'b1) begin
                    delay = {shift_reg[2:0], data};
                    next_state = COUNT_DOWN;
                end
            end

            COUNT_DOWN: begin
                done = 1'b0;
                counting = 1'b1;
                if (counter == 13'd1000) begin
                    if (delay == 0) begin
                        next_state = TIMER_DONE;
                    end else begin
                        delay = delay - 1;
                        counter = 13'd0;
                    end
                end else begin
                    counter = counter + 1;
                end
            end

            TIMER_DONE: begin
                done = 1'b1;
                counting = 1'b0;
                if (ack) begin
                    next_state = WAIT_FOR_PATTERN;
                end else begin
                    next_state = TIMER_DONE;
                end
            end

            default: begin
                next_state = WAIT_FOR_PATTERN;
            end
        endcase
    end

    // Shift register to detect input pattern and read delay
    always @ (posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0;
        end else if (state == WAIT_FOR_PATTERN || state == READ_DELAY) begin
            shift_reg <= {shift_reg[2:0], data};
        end
    end

    // Counter logic
    always @ (posedge clk) begin
        if (reset || state == WAIT_FOR_PATTERN) begin
            counter <= 13'd0;
            delay <= 4'd0;
        end else if (state == COUNT_DOWN) begin
            if (counter < 13'd1000) begin
                counter <= counter + 1;
            end else begin
                counter <= 13'd0;
            end
        end
    end
    
    // Count output logic
    always @ (posedge clk) begin
        if (state == COUNT_DOWN) begin
            count <= delay;
        end else begin
            count <= 4'bx;
        end
    end

endmodule
