module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State Encoding
    typedef enum logic [1:0] {
        WAIT_BYTE1 = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    
    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= WAIT_BYTE1;
        else
            state <= next_state;
    end

    // Next State and Output Logic
    always @* begin
        done = 1'b0; // Default to done being low
        next_state = state; // Default to stay in current state

        case (state)
            WAIT_BYTE1: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1; // Signal done immediately after receiving the 3rd byte
                next_state = WAIT_BYTE1; // Reset to search for a new message
            end
        endcase
    end
    
endmodule
