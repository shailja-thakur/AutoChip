module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // Define the states of the FSM
    typedef enum logic [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        LOAD_DELAY,
        COUNT,
        WAIT_ACK
    } state_t;
    
    state_t state, next_state;

    reg [3:0] delay;
    reg [11:0] cycle_counter;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    next_state = DETECT_1;
            end

            DETECT_1: begin
                if (data == 1'b1)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end

            DETECT_11: begin
                if (data == 1'b0)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end

            DETECT_110: begin
                if (data == 1'b1)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end

            DETECT_1101: begin
                next_state = LOAD_DELAY;
            end

            LOAD_DELAY: begin
                next_state = COUNT;
            end

            COUNT: begin
                if (cycle_counter == 'd0)
                    next_state = WAIT_ACK;
            end

            WAIT_ACK: begin
                if (ack == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end

    // Output logic and internal state updates
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            count <= 0;
            cycle_counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                    count <= 4'bx;
                end

                DETECT_1,
                DETECT_11,
                DETECT_110,
                DETECT_1101: begin
                    // Hold previous counting and done values
                    // No change to count output
                end

                LOAD_DELAY: begin
                    // Shift in the next 4 bits as delay
                    delay <= {delay[2:0], data};
                    if (delay == 4'bxxxx)
                        delay[3] <= data; // Latch the first bit of delay
                    count <= delay;
                end

                COUNT: begin
                    counting <= 1;
                    if (cycle_counter == 12'd0) begin
                        if (count > 0) begin
                            count <= count - 1;
                            cycle_counter <= 12'd1000;
                        end
                    end else begin
                        cycle_counter <= cycle_counter - 1;
                    end
                end

                WAIT_ACK: begin
                    counting <= 0;
                    done <= 1;
                    if (ack) begin
                        done <= 0;
                    end
                end
            endcase
        end
    end

endmodule
