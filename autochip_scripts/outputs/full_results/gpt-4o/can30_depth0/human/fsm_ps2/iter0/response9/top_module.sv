module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State machine encoding
    typedef enum reg [1:0] {
        WAIT_FIRST_BYTE = 2'b00,
        BYTE_ONE_RECEIVED = 2'b01,
        BYTE_TWO_RECEIVED = 2'b10,
        BYTE_THREE_RECEIVED = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= WAIT_FIRST_BYTE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            WAIT_FIRST_BYTE: begin
                if (in[3])
                    next_state = BYTE_ONE_RECEIVED;
                else
                    next_state = WAIT_FIRST_BYTE;
            end
            BYTE_ONE_RECEIVED: begin
                next_state = BYTE_TWO_RECEIVED;
            end
            BYTE_TWO_RECEIVED: begin
                next_state = BYTE_THREE_RECEIVED;
            end
            BYTE_THREE_RECEIVED: begin
                if (in[3])
                    next_state = BYTE_ONE_RECEIVED;
                else
                    next_state = WAIT_FIRST_BYTE;
            end
            default: begin
                next_state = WAIT_FIRST_BYTE;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
        end else begin
            if (current_state == BYTE_THREE_RECEIVED)
                done <= 1'b1;
            else
                done <= 1'b0;
        end
    end
endmodule
