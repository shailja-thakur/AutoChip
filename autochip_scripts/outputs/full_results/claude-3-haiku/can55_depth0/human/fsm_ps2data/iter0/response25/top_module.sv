module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam STATE_WAIT = 2'b00;
localparam STATE_MSG1 = 2'b01;
localparam STATE_MSG2 = 2'b10;
localparam STATE_MSG3 = 2'b11;

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        byte_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        case (state)
            STATE_WAIT: begin
                if (in[3]) begin
                    state <= STATE_MSG1;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
                else begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                    out_bytes <= 0;
                    done <= 0;
                end
            end
            STATE_MSG1: begin
                state <= STATE_MSG2;
                byte_count <= 2;
                out_bytes[15:8] <= in;
            end
            STATE_MSG2: begin
                state <= STATE_MSG3;
                byte_count <= 3;
                out_bytes[7:0] <= in;
            end
            STATE_MSG3: begin
                state <= STATE_WAIT;
                byte_count <= 0;
                done <= 1;
            end
            default: begin
                state <= STATE_WAIT;
                byte_count <= 0;
                out_bytes <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
