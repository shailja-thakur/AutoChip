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
    typedef enum logic [3:0] {
        SEARCH,
        DETECT,
        SHIFT,
        WAIT_COUNTING,
        DONE,
        RESET_STATE
    } state_type;

    // Define the state register
    reg [3:0] state;
  
    // Add an intermediate signal to hold the detected pattern
    reg [3:0] pattern_detected;

    // Define the next state logic and outputs
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RESET_STATE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            pattern_detected <= 0;
        end else begin
            case (state)
                SEARCH: begin
                    if (data == 4'b1101) begin
                        state <= DETECT;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                        pattern_detected <= 1;
                    end
                end
                DETECT: begin
                    state <= SHIFT;
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                    pattern_detected <= 1;
                end
                SHIFT: begin
                    state <= WAIT_COUNTING;
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                    pattern_detected <= 1;
                end
                WAIT_COUNTING: begin
                    if (done_counting) begin
                        state <= DONE;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 1;
                        pattern_detected <= 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        state <= SEARCH;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 1;
                        pattern_detected <= 1;
                    end
                end
                RESET_STATE: begin
                    state <= SEARCH;
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    pattern_detected <= 0;
                end
                default: begin
                    state <= SEARCH;
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    pattern_detected <= 0;
                end
            endcase
        end
    end

    // Add else statements to assign default values to the outputs
    always @* begin
        if (state != DETECT && state != SHIFT && state != WAIT_COUNTING) begin
            shift_ena = 0;
        end
        if (state != WAIT_COUNTING && state != DONE) begin
            counting = 0;
        end
        if (state != DONE) begin
            done = 0;
        end
    end

endmodule
