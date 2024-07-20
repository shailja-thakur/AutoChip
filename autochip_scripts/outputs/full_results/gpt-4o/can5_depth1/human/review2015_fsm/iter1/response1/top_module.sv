module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    // Declare states
    typedef enum reg [2:0] {
        IDLE,            // Look for 1101
        DETECT_1,        // Detected 1, look for 1
        DETECT_11,       // Detected 11, look for 0
        DETECT_110,      // Detected 110, look for 1
        SHIFT,           // Shift 4-bit data
        WAIT_COUNT,      // Wait for counters to finish counting
        NOTIFY           // Notify user
    } state_t;
    state_t state, next_state;

    reg [2:0] shift_counter;    // Counter to count 4 cycles for shifting

    // State transition logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 0;
        end else begin
            state <= next_state;
            if (state == SHIFT)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 0;
        end
    end

    // Next state logic (combinational)
    always @(*) begin
        // Default outputs
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;

        case (state)
            IDLE: begin
                if (data) next_state = DETECT_1;
            end

            DETECT_1: begin
                if (data) next_state = DETECT_11;
                else next_state = IDLE;
            end

            DETECT_11: begin
                if (!data) next_state = DETECT_110;
                else next_state = IDLE;
            end

            DETECT_110: begin
                if (data) next_state = SHIFT;
                else next_state = IDLE;
            end

            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 3)
                    next_state = WAIT_COUNT;
            end

            WAIT_COUNT: begin
                counting = 1;
                if (done_counting) next_state = NOTIFY;
            end

            NOTIFY: begin
                done = 1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule
