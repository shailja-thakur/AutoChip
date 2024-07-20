module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State Definitions
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    // State Registers
    state_t current_state, next_state;

    // State Transition Logic
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset)
            done <= 0;
        else if (current_state == BYTE3)
            done <= 1;
        else
            done <= 0;
    end

endmodule
