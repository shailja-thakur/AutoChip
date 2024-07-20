module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define the states of the finite-state machine
    typedef enum logic [2:0] {
        IDLE,
        DETECT_PATTERN,
        SHIFT_ENABLE,
        WAIT_COUNTING_DONE,
        NOTIFY_DONE,
        WAIT_ACK
    } state_t;

    // Define the signals for the state machine
    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            // Reset the state machine to the initial state
            state <= IDLE;
        end else begin
            // Transition to the next state based on the current state
            state <= next_state;
        end
    end

    always @(*) begin
        // Default next state is the current state
        next_state = state;

        case (state)
            IDLE:
                if (data == 4'b1101) begin
                    next_state = DETECT_PATTERN;
                end
            DETECT_PATTERN:
                next_state = SHIFT_ENABLE;
            SHIFT_ENABLE:
                next_state = WAIT_COUNTING_DONE;
            WAIT_COUNTING_DONE:
                if (done_counting) begin
                    next_state = NOTIFY_DONE;
                end
            NOTIFY_DONE:
                if (ack) begin
                    next_state = WAIT_ACK;
                end
            WAIT_ACK:
                next_state = IDLE;
        endcase
    end

    always @(state) begin
        // Assign outputs based on the current state
        case (state)
            IDLE:
                shift_ena = 1'b0;
                counting = 1'b0;
                done = 1'b0;
            DETECT_PATTERN:
                shift_ena = 1'b1;
                counting = 1'b0;
                done = 1'b0;
            SHIFT_ENABLE:
                shift_ena = 1'b1;
                counting = 1'b0;
                done = 1'b0;
            WAIT_COUNTING_DONE:
                shift_ena = 1'b0;
                counting = 1'b1;
                done = 1'b0;
            NOTIFY_DONE:
                shift_ena = 1'b0;
                counting = 1'b1;
                done = 1'b1;
            WAIT_ACK:
                shift_ena = 1'b0;
                counting = 1'b0;
                done = 1'b1;
        endcase
    end
endmodule
