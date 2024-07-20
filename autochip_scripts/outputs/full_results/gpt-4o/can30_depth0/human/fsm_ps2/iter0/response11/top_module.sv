module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        WAIT_START = 2'b00,
        BYTE_1     = 2'b01,
        BYTE_2     = 2'b10,
        BYTE_3     = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WAIT_START: begin
                if (in[3])  // Check if the 4th bit (in[3]) is 1
                    next_state = BYTE_1;
                else
                    next_state = WAIT_START;
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = WAIT_START;
            default: next_state = WAIT_START;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_START;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 1'b0;
        else if (state == BYTE_3)
            done <= 1'b1;
        else
            done <= 1'b0;
    end

endmodule
