module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] buffer;

    localparam IDLE = 2'b00,
               BYTE1 = 2'b01,
               BYTE2 = 2'b10,
               BYTE3 = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == BYTE3 && !reset) begin
                out_bytes <= buffer;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        buffer = out_bytes;

        case(state)
            IDLE: begin
                if (in[3] == 1) begin
                    buffer[23:16] = in;
                    next_state = BYTE1;
                end
            end

            BYTE1: begin
                buffer[15:8] = in;
                next_state = BYTE2;
            end

            BYTE2: begin
                buffer[7:0] = in;
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
