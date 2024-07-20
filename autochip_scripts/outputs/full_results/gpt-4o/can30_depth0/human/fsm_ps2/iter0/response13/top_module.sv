module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    typedef enum reg [1:0] {
        WAIT_FOR_START = 2'd0,
        BYTE1_RECEIVED = 2'd1,
        BYTE2_RECEIVED = 2'd2,
        BYTE3_RECEIVED = 2'd3
    } state_t;

    state_t state, next_state;

    always @(*) begin
        case (state)
            WAIT_FOR_START: begin
                if (in[3] == 1)
                    next_state = BYTE1_RECEIVED;
                else
                    next_state = WAIT_FOR_START;
            end
            BYTE1_RECEIVED: begin
                next_state = BYTE2_RECEIVED;
            end
            BYTE2_RECEIVED: begin
                next_state = BYTE3_RECEIVED;
            end
            BYTE3_RECEIVED: begin
                next_state = WAIT_FOR_START;
            end
            default: next_state = WAIT_FOR_START;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_START;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end else begin
            if (state == BYTE3_RECEIVED) begin
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end
endmodule
