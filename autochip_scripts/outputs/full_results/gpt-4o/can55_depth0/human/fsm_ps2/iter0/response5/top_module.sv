module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State declaration
    typedef enum reg [1:0] {
        WAIT_BYTE1,  // Waiting for the first byte with in[3]=1
        GOT_BYTE1,   // Received the first byte, waiting for the second byte
        GOT_BYTE2    // Received the second byte, waiting for the third byte
    } state_t;

    state_t current_state, next_state;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= WAIT_BYTE1;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        done = 0;
        case (current_state)
            WAIT_BYTE1: begin
                if (in[3] == 1)
                    next_state = GOT_BYTE1;
                else
                    next_state = WAIT_BYTE1;
            end
            GOT_BYTE1: begin
                next_state = GOT_BYTE2;
            end
            GOT_BYTE2: begin
                next_state = WAIT_BYTE1;
                done = 1;
            end
        endcase
    end

endmodule
