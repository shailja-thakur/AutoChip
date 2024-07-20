module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] message_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_bytes <= 24'b0;
            message_reg <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state == IDLE) done <= 1'b0;
            if (state == BYTE3) begin
                out_bytes <= {message_reg[15:0], in};
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
            if (next_state == BYTE1) message_reg[23:16] <= in;
            if (next_state == BYTE2) message_reg[15:8] <= in;
            if (next_state == BYTE3) message_reg[7:0] <= in;
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
