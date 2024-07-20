module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] buffer;

    localparam WAIT = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, BYTE3 = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (state == BYTE1) begin
            buffer[23:16] <= in;
        end else if (state == BYTE2) begin
            buffer[15:8] <= in;
        end else if (state == BYTE3) begin
            buffer[7:0] <= in;
            out_bytes <= buffer;
        end
    end

    always @(*) begin
        next_state = state;
        done = 0;

        case(state)
            WAIT: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = WAIT;
                done = 1;
            end
        endcase
    end

endmodule
