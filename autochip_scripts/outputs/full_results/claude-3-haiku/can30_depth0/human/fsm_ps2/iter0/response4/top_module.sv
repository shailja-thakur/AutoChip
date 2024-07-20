module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT = 0, STATE_BYTE1 = 1, STATE_BYTE2 = 2, STATE_BYTE3 = 3;
reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            STATE_WAIT: begin
                if (in[3]) begin
                    state <= STATE_BYTE1;
                    byte_count <= 1;
                end
                else begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                end
                done <= 0;
            end
            STATE_BYTE1: begin
                if (in[3]) begin
                    state <= STATE_BYTE2;
                    byte_count <= 2;
                end
                else begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                end
                done <= 0;
            end
            STATE_BYTE2: begin
                if (in[3]) begin
                    state <= STATE_BYTE3;
                    byte_count <= 3;
                end
                else begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                end
                done <= 0;
            end
            STATE_BYTE3: begin
                if (in[3]) begin
                    state <= STATE_BYTE1;
                    byte_count <= 1;
                end
                else begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                end
                done <= 1;
            end
        endcase
    end
end

endmodule
