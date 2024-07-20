module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

    // Define states
    typedef enum logic [1:0] {
        WAIT_FOR_FIRST_BYTE = 2'b00,
        WAIT_FOR_SECOND_BYTE = 2'b01,
        WAIT_FOR_THIRD_BYTE = 2'b10
    } state_t;

    // State, next state variables
    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= WAIT_FOR_FIRST_BYTE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        done = 1'b0; // Default value
        case (state)
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3] == 1'b1)
                    next_state = WAIT_FOR_SECOND_BYTE;
                else
                    next_state = WAIT_FOR_FIRST_BYTE;
            end
            WAIT_FOR_SECOND_BYTE: begin
                next_state = WAIT_FOR_THIRD_BYTE;
            end
            WAIT_FOR_THIRD_BYTE: begin
                done = 1'b1; // Signal done after the third byte was received
                next_state = WAIT_FOR_FIRST_BYTE;
            end
            default: begin
                next_state = WAIT_FOR_FIRST_BYTE;
            end
        endcase
    end

endmodule
