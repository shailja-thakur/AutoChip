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
        BYTE_3 = 2'b11
    } state_t;

    state_t state, next_state;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE_1;
                else
                    next_state = IDLE;
            end

            BYTE_1: next_state = BYTE_2;

            BYTE_2: next_state = BYTE_3;

            BYTE_3: next_state = IDLE;

            default: next_state = IDLE;
        endcase
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
