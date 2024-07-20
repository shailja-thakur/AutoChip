module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Define the states using an enum
    typedef enum logic [1:0] {
        BYTE1, BYTE2, BYTE3, DONE
    } state_t;

    // Define registers for the current state and next state
    state_t current_state, next_state;

    // Define a register to hold the value of the third bit of the input
    reg third_bit;

    // Sequential logic for the state machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the state machine to the initial state BYTE1
            current_state <= BYTE1;
        end else begin
            // Update the current state with the next state at the positive edge of the clock
            current_state <= next_state;
        end
    end

    // Combinational logic for the next state and done signal
    always @* begin
        next_state = current_state;
        third_bit = in[2];

        case (current_state)
            BYTE1: begin
                if (third_bit == 1'b1) begin
                    next_state = BYTE2;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (third_bit == 1'b0) begin
                    next_state = BYTE1;
                end else begin
                    next_state = BYTE2;
                end
            end
        endcase

        done = (current_state == DONE);
    end

endmodule
