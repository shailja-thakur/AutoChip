module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states
    typedef enum reg [2:0] {
        IDLE,          // Initial state, looking for 1101
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        SHIFT,          // Shift state for 4 cycles
        COUNT,          // Waiting for the counter to finish
        DONE            // Notify user and wait for ack
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_count;  // Counter for 4 clock cycles in SHIFT state

    // State transition and output logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_count <= 0;
        end else begin
            state <= next_state; // Update state

            // Outputs default to 0 unless set in the state machine
            shift_ena <= 0;
            counting <= 0;
            done <= 0;

            case (state)
                IDLE: begin
                    // Look for the 1101 pattern
                    if (data) begin
                        next_state <= DETECT_1;
                    end
                end

                DETECT_1: begin
                    if (data)
                        next_state <= DETECT_11;
                    else
                        next_state <= IDLE;
                end

                DETECT_11: begin
                    if (~data)
                        next_state <= DETECT_110;
                    else
                        next_state <= IDLE;
                end

                DETECT_110: begin
                    if (data)
                        next_state <= DETECT_1101;
                    else
                        next_state <= IDLE;
                end

                DETECT_1101: begin
                    // Pattern detected, start shifting
                    shift_ena <= 1;
                    next_state <= SHIFT;
                end

                SHIFT: begin
                    shift_ena <= 1;
                    if (shift_count == 3) begin
                        next_state <= COUNT;
                    end else begin
                        shift_count <= shift_count + 1;
                    end
                end

                COUNT: begin
                    counting <= 1;
                    if (done_counting) begin
                        next_state <= DONE;
                    end
                end

                DONE: begin
                    done <= 1;
                    if (ack) begin
                        next_state <= IDLE;
                    end
                end
            endcase
        end
    end

    // Next state logic
    always @ (*) begin
        case (state)
            IDLE: next_state = data ? DETECT_1 : IDLE;
            DETECT_1: next_state = data ? DETECT_11 : IDLE;
            DETECT_11: next_state = data ? DETECT_11 : (data ? DETECT_110 : IDLE);
            DETECT_110: next_state = data ? DETECT_1101 : IDLE;
            DETECT_1101: next_state = SHIFT;
            SHIFT: next_state = (shift_count == 3) ? COUNT : SHIFT;
            COUNT: next_state = done_counting ? DONE : COUNT;
            DONE: next_state = ack ? IDLE : DONE;
            default: next_state = IDLE; // Default state to handle invalid states
        endcase
    end

endmodule
