module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define the states for the finite state machine
    typedef enum logic [1:0] {
        IDLE,
        DETECT_PATTERN,
        SHIFT_ENA,
        WAIT_DONE_COUNTING,
        NOTIFY_DONE,
        WAIT_ACK
    } state_type;

    // Create a reg to hold the current state
    reg [1:0] curr_state;

    // Create a reg to hold the next state
    reg [1:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            curr_state <= IDLE;  // Reset to initial state
        end else begin
            curr_state <= next_state;  // Update current state with next state
        end
    end

    always @(curr_state or data or done_counting or ack) begin
        // Default next state assignment
        next_state = curr_state;

        case (curr_state)
            IDLE: begin
                if (data == 4'b1101) begin
                    next_state = DETECT_PATTERN;
                end
            end

            DETECT_PATTERN: begin
                next_state = SHIFT_ENA;
            end

            SHIFT_ENA: begin
                next_state = WAIT_DONE_COUNTING;
                shift_ena = 1;
                counting = 1;  // Assert counting signal
            end

            WAIT_DONE_COUNTING: begin
                if (done_counting) begin
                    next_state = NOTIFY_DONE;
                    counting = 0;  // Deassert counting signal
                end
            end

            NOTIFY_DONE: begin
                next_state = WAIT_ACK;
                done = 1;  // Assert done signal
            end

            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                    done = 0;  // Deassert done signal
                end
            end
        endcase
    end

endmodule
