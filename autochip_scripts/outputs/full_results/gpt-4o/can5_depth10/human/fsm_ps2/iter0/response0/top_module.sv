module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        WAIT_BYTE1 = 2'b00,
        WAIT_BYTE2 = 2'b01,
        WAIT_BYTE3 = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_BYTE1;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT_BYTE1: begin
                if (in[3])
                    next_state = WAIT_BYTE2;
                else
                    next_state = WAIT_BYTE1;
            end
            WAIT_BYTE2: begin
                next_state = WAIT_BYTE3;
            end
            WAIT_BYTE3: begin
                next_state = WAIT_BYTE1;
            end
            default: begin
                next_state = WAIT_BYTE1;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 0;
        else begin
            if (state == WAIT_BYTE3)
                done <= 1;
            else
                done <= 0;
        end
    end

endmodule
