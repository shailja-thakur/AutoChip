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
        START,
        SHIFT_ENA,
        COUNTING,
        DONE
    } state_t;

    // Define the current state variable
    state_t current_state;

    // Define the next state variable
    state_t next_state;

    always @(posedge clk) begin
        if (reset) begin
            // Reset the state machine
            current_state <= START;
        end else begin
            // Update the current state
            current_state <= next_state;
        end
    end

    always @(posedge clk) begin
        // Default assignments
        shift_ena <= 0;
        counting <= 0;
        done <= 0;

        // Calculate the next state
        case (current_state)
            START: begin
                if (data === 4'b1101) begin
                    next_state = SHIFT_ENA;
                end else begin
                    next_state = START;
                end
            end

            SHIFT_ENA: begin
                next_state = COUNTING;
                shift_ena = 1;
            end

            COUNTING: begin
                if (done_counting) begin
                    next_state = DONE;
                    counting = 1;
                end else begin
                    next_state = COUNTING;
                end
            end

            DONE: begin
                if (ack) begin
                    next_state = START;
                    done = 1;
                end else begin
                    next_state = DONE;
                end
            end
        endcase
    end
endmodule
