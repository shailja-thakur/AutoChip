module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // Define the states
    typedef enum logic [2:0] {
        IDLE, DETECT_1, DETECT_11, DETECT_110, DETECT_1101, SHIFT_IN_DELAY,
        COUNTING, DONE
    } state_t;
    
    state_t state, next_state;
    reg [3:0] delay, delay_counter;
    reg [15:0] counter; // This will count up to (delay + 1) * 1000 cycles

    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        
        case(state)
            IDLE: begin
                if (data)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (!data)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                if (delay_counter == 4)
                    next_state = COUNTING;
                else
                    next_state = SHIFT_IN_DELAY;
            end
            SHIFT_IN_DELAY: begin
                if (delay_counter == 4)
                    next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1'b1;
                if (counter == 0)
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            delay <= 0;
            count <= 0;
            counter <= 0;
            delay_counter <= 0;
        end else begin
            case(state)
                IDLE: begin
                    delay <= 0;
                end
                DETECT_1101: begin
                    delay_counter <= 0;
                end
                SHIFT_IN_DELAY: begin
                    delay <= {delay[2:0], data};
                    delay_counter <= delay_counter + 1;
                end
                COUNTING: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter[9:0] == 0) // Every 1000 cycles
                            count <= count - 1;
                    end else begin
                        count <= 0;
                    end
                end
                DONE: begin
                    counter <= 0;
                    count <= 0;
                end
            endcase

            if (state == COUNTING && next_state != COUNTING) begin
                delay_counter <= 0;
                delay <= 0;
            end else if (state == DETECT_1101 && next_state == SHIFT_IN_DELAY) begin
                counter <= (delay + 1) * 1000;
                count <= delay;
            end
        end
    end
endmodule
