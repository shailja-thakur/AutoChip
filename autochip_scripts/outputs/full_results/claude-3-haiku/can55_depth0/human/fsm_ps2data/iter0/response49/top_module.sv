module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam [1:0] WAIT = 2'b00, RECV_BYTE1 = 2'b01, RECV_BYTE2 = 2'b10, RECV_BYTE3 = 2'b11;
reg [1:0] state, next_state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        byte_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;

        case (state)
            WAIT: begin
                if (in[3]) begin
                    next_state <= RECV_BYTE1;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
                else begin
                    next_state <= WAIT;
                    byte_count <= 0;
                    out_bytes <= 0;
                end
                done <= 0;
            end
            RECV_BYTE1: begin
                next_state <= RECV_BYTE2;
                byte_count <= 2;
                out_bytes[15:8] <= in;
                done <= 0;
            end
            RECV_BYTE2: begin
                next_state <= RECV_BYTE3;
                byte_count <= 3;
                out_bytes[7:0] <= in;
                done <= 0;
            end
            RECV_BYTE3: begin
                next_state <= WAIT;
                byte_count <= 0;
                done <= 1;
            end
            default: begin
                next_state <= WAIT;
                byte_count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
