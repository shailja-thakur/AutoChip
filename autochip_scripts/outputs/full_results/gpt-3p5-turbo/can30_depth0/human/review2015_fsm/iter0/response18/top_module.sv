module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define the states of the state machine
    parameter START = 2'b00;
    parameter DETECT_PATTERN = 2'b01;
    parameter SHIFT_IN_DATA = 2'b10;
    parameter WAIT_FOR_COUNTING = 2'b11;

    // Define the current state variable
    reg [1:0] state;

    // Define the next state variable
    reg [1:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            // If reset is asserted, reset the state machine to the start state
            state <= START;
        end else begin
            // Update the current state based on the next state
            state <= next_state;
        end
    end

    always @* begin
        next_state = state; // Assign next_state to current state by default

        case (state)
            START: begin
                // When in the START state, look for the start sequence (1101)
                if (data == 4'b1101) begin
                    // If the start sequence is detected, move to the DETECT_PATTERN state
                    next_state = DETECT_PATTERN;
                end
            end
            DETECT_PATTERN: begin
                // When in the DETECT_PATTERN state, assert shift_ena for 4 clock cycles
                shift_ena = 1;
                next_state = SHIFT_IN_DATA;
            end
            SHIFT_IN_DATA: begin
                // When in the SHIFT_IN_DATA state, wait for 4 more bits to be shifted in
                counting = 1; // Assert counting output
                if (done_counting) begin
                    // If done_counting is high, move to the WAIT_FOR_COUNTING state
                    next_state = WAIT_FOR_COUNTING;
                end
            end
            WAIT_FOR_COUNTING: begin
                // When in the WAIT_FOR_COUNTING state, wait for done_counting to go high
                done = 1; // Assert done output
                if (ack) begin
                    // If ack is high, reset the state machine to START state
                    next_state = START;
                end
            end
        endcase
    end
endmodule
