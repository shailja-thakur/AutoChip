module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Declare states for the finite-state machine
    typedef enum logic [2:0] {
        IDLE,
        DETECT_PATTERN,
        SHIFT_ENA,
        COUNTING,
        TIMER_DONE,
        WAIT_ACK
    } fsm_state;

    // Declare reg variables for the state machine
    reg [2:0] state;
    reg [3:0] counter;

    // Default values for outputs
    assign shift_ena = 1'b0;
    assign counting = 1'b0;
    assign done = 1'b0;

    // Synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1 && $past(data) == 1'b1 && $past($past(data)) == 1'b0) begin
                        state <= DETECT_PATTERN;
                    end else begin
                        state <= IDLE;
                    end
                end

                DETECT_PATTERN: begin
                    if (data == 1'b0 && $past(data) == 1'b1) begin
                        state <= SHIFT_ENA;
                    end else begin
                        state <= DETECT_PATTERN;
                    end
                end

                SHIFT_ENA: begin
                    if (counter < 4'b1111) begin
                        counter <= counter + 1'b1;
                        state <= SHIFT_ENA;
                    end else begin
                        counter <= 4'b0;
                        state <= COUNTING;
                    end
                end

                COUNTING: begin
                    if (done_counting) begin
                        state <= TIMER_DONE;
                    end else begin
                        state <= COUNTING;
                    end
                end

                TIMER_DONE: begin
                    if (ack) begin
                        state <= WAIT_ACK;
                    end else begin
                        state <= TIMER_DONE;
                    end
                end

                WAIT_ACK: begin
                    if (ack) begin
                        state <= IDLE;
                    end else begin
                        state <= WAIT_ACK;
                    end
                end
            endcase
        end
    end

    // Output assignment based on current state
    always @(state) begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end

            DETECT_PATTERN: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end

            SHIFT_ENA: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end

            COUNTING: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
            end

            TIMER_DONE: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b1;
            end

            WAIT_ACK: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b1;
            end
        endcase
    end

endmodule
