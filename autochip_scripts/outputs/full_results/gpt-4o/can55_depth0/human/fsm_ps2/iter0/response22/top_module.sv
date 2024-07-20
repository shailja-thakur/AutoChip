module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // FSM state encoding
    typedef enum reg [1:0] {
        WAIT_FOR_FIRST_BYTE = 2'b00,
        BYTE1_RECEIVED      = 2'b01,
        BYTE2_RECEIVED      = 2'b10,
        BYTE3_RECEIVED      = 2'b11
    } state_t;

    state_t state, next_state;

    // FSM state transitions
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_FOR_FIRST_BYTE;
        else
            state <= next_state;
    end

    // FSM next state logic and output logic
    always @(*) begin
        done = 0;
        next_state = state;
        case (state)
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3]) // First byte boundary detected
                    next_state = BYTE1_RECEIVED;
            end
            BYTE1_RECEIVED: begin
                next_state = BYTE2_RECEIVED;
            end
            BYTE2_RECEIVED: begin
                next_state = BYTE3_RECEIVED;
            end
            BYTE3_RECEIVED: begin
                next_state = WAIT_FOR_FIRST_BYTE;
                done = 1; // Indicate message complete after third byte received
            end
        endcase
    end

endmodule
