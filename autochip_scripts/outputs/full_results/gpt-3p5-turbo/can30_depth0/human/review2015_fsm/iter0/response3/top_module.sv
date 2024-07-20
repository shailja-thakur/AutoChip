module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define the states
    typedef enum logic [2:0] {
        IDLE,
        DETECT_PATTERN,
        SHIFT_ENA,
        WAIT_COUNTING,
        NOTIFY_DONE,
        WAIT_ACK,
        RESET
    } state_t;

    // Initialize the state and counters
    reg [2:0] state;
    reg [3:0] delay_counter;
    reg [1:0] ack_counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RESET;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            delay_counter <= 0;
            ack_counter <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (data[3:0] == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                    else begin
                        state <= IDLE;
                    end
                end

                DETECT_PATTERN: begin
                    shift_ena <= 1;
                    state <= SHIFT_ENA;
                end

                SHIFT_ENA: begin
                    if (delay_counter < 4) begin
                        delay_counter <= delay_counter + 1;
                        state <= SHIFT_ENA;
                    end
                    else begin
                        delay_counter <= 0;
                        counting <= 1;
                        state <= WAIT_COUNTING;
                    end
                end

                WAIT_COUNTING: begin
                    if (done_counting) begin
                        done <= 1;
                        state <= NOTIFY_DONE;
                    end
                    else begin
                        state <= WAIT_COUNTING;
                    end
                end

                NOTIFY_DONE: begin
                    if (ack) begin
                        ack_counter <= 0;
                        state <= WAIT_ACK;
                    end
                    else begin
                        state <= NOTIFY_DONE;
                    end
                end

                WAIT_ACK: begin
                    if (ack) begin
                        ack_counter <= ack_counter + 1;
                        state <= WAIT_ACK;
                    end
                    else begin
                        ack_counter <= 0;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        state <= IDLE;
                    end
                end

                RESET: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    delay_counter <= 0;
                    ack_counter <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
