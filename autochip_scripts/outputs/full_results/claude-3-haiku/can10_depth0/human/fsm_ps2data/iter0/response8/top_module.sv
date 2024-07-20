module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam [1:0] IDLE = 2'b00,
                 READ_BYTE1 = 2'b01,
                 READ_BYTE2 = 2'b10,
                 READ_BYTE3 = 2'b11;

reg [1:0] state, next_state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state <= READ_BYTE1;
                    byte_count <= 1;
                end
                else begin
                    next_state <= IDLE;
                    byte_count <= 0;
                end
                out_bytes <= 0;
                done <= 0;
            end
            READ_BYTE1: begin
                out_bytes[23:16] <= in;
                next_state <= READ_BYTE2;
                byte_count <= 2;
            end
            READ_BYTE2: begin
                out_bytes[15:8] <= in;
                next_state <= READ_BYTE3;
                byte_count <= 3;
            end
            READ_BYTE3: begin
                out_bytes[7:0] <= in;
                next_state <= IDLE;
                byte_count <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
