module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [1:0] state, next_state;
    reg [23:0] temp_bytes;
    parameter IDLE = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, DONE = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_bytes <= 24'b0;
            done <= 0;
            temp_bytes <= 24'b0;
        end else begin
            state <= next_state;
            if (state == BYTE2 && next_state == DONE) begin
                out_bytes <= temp_bytes;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                    temp_bytes[23:16] = in;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
                temp_bytes[15:8] = in;
            end
            BYTE2: begin
                next_state = DONE;
                temp_bytes[7:0] = in;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
