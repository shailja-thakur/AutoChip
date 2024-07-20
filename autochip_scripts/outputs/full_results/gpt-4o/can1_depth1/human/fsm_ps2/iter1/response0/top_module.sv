module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state;
        done = 1'b0;  // Default done to 0
        case (state)
            IDLE: begin
                if (in[3] == 1) next_state = BYTE_1;
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = DONE;
            DONE: begin
                next_state = IDLE;
                done = 1'b1;  // Signal done after receiving third byte
            end
        endcase
    end

    // Synchronous state update
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
endmodule
