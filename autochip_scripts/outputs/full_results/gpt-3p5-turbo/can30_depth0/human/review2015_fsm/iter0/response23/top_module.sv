module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define state enum
    typedef enum logic [3:0] {
        IDLE,
        DETECT_PATTERN,
        SHIFT_IN,
        WAIT_COUNTING,
        NOTIFY,
        WAIT_ACK
    } state_t;

    // Declare state and next_state variables
    reg [3:0] state, next_state;

    // Declare internal signal
    reg detect_pattern;

    // State register
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case(state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = DETECT_PATTERN;
                end
            end
            DETECT_PATTERN: begin
                detect_pattern = 1;
                next_state = SHIFT_IN;
            end
            SHIFT_IN: begin
                if (detect_pattern && counting) begin
                    shift_ena = 1;
                    next_state = WAIT_COUNTING;
                end else if (!counting) begin
                    shift_ena = 0;
                    next_state = WAIT_COUNTING;
                end
            end
            WAIT_COUNTING: begin
                counting = 1;
                if (done_counting) begin
                    next_state = NOTIFY;
                end
            end
            NOTIFY: begin
                done = 1;
                next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                done = 0;
                if (ack) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
