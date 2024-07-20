module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // State encoding
    typedef enum reg [1:0] {
        WAIT_FIRST_BYTE = 2'b00,
        RECV_SECOND_BYTE = 2'b01,
        RECV_THIRD_BYTE = 2'b10
    } state_t;

    state_t state, next_state;
    reg [1:0] byte_count;

    // State transitions
    always @(posedge clk) begin
        if (reset)
            state <= WAIT_FIRST_BYTE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT_FIRST_BYTE: begin
                if (in[3] == 1'b1)
                    next_state = RECV_SECOND_BYTE;
                else
                    next_state = WAIT_FIRST_BYTE;
            end
            RECV_SECOND_BYTE: begin
                next_state = RECV_THIRD_BYTE;
            end
            RECV_THIRD_BYTE: begin
                next_state = WAIT_FIRST_BYTE;
            end
            default: begin
                next_state = WAIT_FIRST_BYTE;
            end
        endcase
    end

    // Byte count and done signal logic
    always @(posedge clk) begin
        if (reset) begin
            byte_count <= 2'b00;
            done <= 1'b0;
        end
        else if (state == RECV_SECOND_BYTE) begin
            byte_count <= 2'b01;
            done <= 1'b0;
        end
        else if (state == RECV_THIRD_BYTE) begin
            byte_count <= 2'b10;
            done <= 1'b0;
        end
        else if (state == WAIT_FIRST_BYTE && byte_count == 2'b10) begin
            byte_count <= 2'b00;
            done <= 1'b1;  // Signal done on the cycle immediately after the third byte
        end
        else begin
            byte_count <= 2'b00;
            done <= 1'b0;
        end
    end

endmodule
