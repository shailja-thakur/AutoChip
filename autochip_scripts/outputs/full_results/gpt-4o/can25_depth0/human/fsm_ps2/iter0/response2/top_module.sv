module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encodings
    typedef enum logic [1:0] {
        WAIT_FOR_START = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_START;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == BYTE_3)
                done <= 1'b1;
            else
                done <= 1'b0;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            WAIT_FOR_START: begin
                if (in[3] == 1'b1)
                    next_state = BYTE_1;
                else
                    next_state = WAIT_FOR_START;
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = WAIT_FOR_START;
            default: next_state = WAIT_FOR_START;
        endcase
    end

endmodule
