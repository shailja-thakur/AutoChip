module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State Declaration
    typedef enum logic [1:0] {
        IDLE         = 2'b00,
        BYTE1        = 2'b01,
        BYTE2        = 2'b10,
        BYTE3        = 2'b11
    } state_t;

    // State Register
    state_t state, next_state;

    // Output Register
    reg done_reg;

    // Next State Logic
    always @(*) begin
        done_reg = 0;
        case (state)
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: begin
                next_state = IDLE;
                done_reg = 1;
            end
            default: next_state = IDLE;
        endcase
    end

    // State Register Update
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output Assignment
    assign done = done_reg;

endmodule
