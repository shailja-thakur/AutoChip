module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {STATE_IDLE, STATE_BYTE1, STATE_BYTE2, STATE_BYTE3} state_t;
    state_t state, next_state;
    reg [7:0] byte1, byte2, byte3;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_IDLE;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
        end else begin
            state <= next_state;

            if (next_state == STATE_BYTE1)
                byte1 <= in;
            else if (next_state == STATE_BYTE2)
                byte2 <= in;
            else if (next_state == STATE_BYTE3)
                byte3 <= in;
        end
    end

    always @(*) begin
        next_state = state;
        done = 1'b0;

        case (state)
            STATE_IDLE: begin
                if (in[3] == 1'b1)
                    next_state = STATE_BYTE1;
            end
            STATE_BYTE1: next_state = STATE_BYTE2;
            STATE_BYTE2: next_state = STATE_BYTE3;
            STATE_BYTE3: begin
                done = 1'b1;
                next_state = STATE_IDLE;
            end
        endcase
    end

    always @(*) begin
        if (done)
            out_bytes = {byte1, byte2, byte3};
        else
            out_bytes = 24'bx;
    end
endmodule
