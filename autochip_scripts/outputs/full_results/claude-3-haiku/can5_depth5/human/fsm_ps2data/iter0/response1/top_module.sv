module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam [1:0] STATE_WAIT = 2'b00, STATE_BYTE1 = 2'b01, STATE_BYTE2 = 2'b10, STATE_BYTE3 = 2'b11;
reg [1:0] state, next_state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        byte_count <= 3'b000;
        out_bytes <= 24'h000000;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WAIT: begin
                if (in[3]) begin
                    out_bytes[23:16] <= in;
                    byte_count <= 3'b001;
                    next_state <= STATE_BYTE2;
                end
                else begin
                    next_state <= STATE_WAIT;
                end
            end
            STATE_BYTE2: begin
                out_bytes[15:8] <= in;
                byte_count <= 3'b010;
                next_state <= STATE_BYTE3;
            end
            STATE_BYTE3: begin
                out_bytes[7:0] <= in;
                byte_count <= 3'b011;
                done <= 1'b1;
                next_state <= STATE_WAIT;
            end
            default: begin
                next_state <= STATE_WAIT;
            end
        endcase
    end
end

endmodule
