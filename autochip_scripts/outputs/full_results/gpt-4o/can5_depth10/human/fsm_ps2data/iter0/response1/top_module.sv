module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {
        WAIT_FOR_FIRST_BYTE = 2'b00,
        RECEIVE_SECOND_BYTE = 2'b01,
        RECEIVE_THIRD_BYTE  = 2'b10
    } state_t;

    reg [1:0] state, next_state;
    reg [7:0] byte1, byte2, byte3;

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_FIRST_BYTE;
            done <= 0;
            out_bytes <= 24'b0;
        end else begin
            state <= next_state;
            if (next_state == WAIT_FOR_FIRST_BYTE && state == RECEIVE_THIRD_BYTE) begin
                done <= 1;
                out_bytes <= {byte1, byte2, byte3};
            end else begin
                done <= 0;
            end
        end
    end

    always @* begin
        next_state = state;
        case (state)
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3] == 1) begin
                    byte1 = in;
                    next_state = RECEIVE_SECOND_BYTE;
                end
            end
            RECEIVE_SECOND_BYTE: begin
                byte2 = in;
                next_state = RECEIVE_THIRD_BYTE;
            end
            RECEIVE_THIRD_BYTE: begin
                byte3 = in;
                next_state = WAIT_FOR_FIRST_BYTE;
            end
            default: next_state = WAIT_FOR_FIRST_BYTE;
        endcase
    end

endmodule
