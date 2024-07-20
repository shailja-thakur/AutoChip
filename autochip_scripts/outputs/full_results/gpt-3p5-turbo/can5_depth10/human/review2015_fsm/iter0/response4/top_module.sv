module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [3:0] state;

    // states for the finite-state machine
    parameter IDLE = 0;
    parameter DETECT_PATTERN = 1;
    parameter SHIFT_ENABLE = 2;
    parameter WAIT_COUNTING = 3;
    parameter TIMER_DONE = 4;
    parameter WAIT_ACK = 5;

    // output register initialization
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;    // reset state to IDLE
        else
            state <= next_state;
    end

    // next state logic
    reg [3:0] next_state;
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = DETECT_PATTERN;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT_PATTERN: begin
                next_state = SHIFT_ENABLE;
            end
            SHIFT_ENABLE: begin
                if (shift_ena) begin
                    next_state = SHIFT_ENABLE;
                end else begin
                    next_state = WAIT_COUNTING;
                end
            end
            WAIT_COUNTING: begin
                if (done_counting) begin
                    next_state = TIMER_DONE;
                end else begin
                    next_state = WAIT_COUNTING;
                end
            end
            TIMER_DONE: begin
                next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_ACK;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // output logic
    always @(state) begin
        case (state)
            IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_PATTERN: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            SHIFT_ENABLE: begin
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            end
            WAIT_COUNTING: begin
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
            end
            TIMER_DONE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
            WAIT_ACK: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
        endcase
    end

endmodule
