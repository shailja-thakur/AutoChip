module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT = 2'd0;
localparam STATE_BYTE1 = 2'd1;
localparam STATE_BYTE2 = 2'd2;
localparam STATE_BYTE3 = 2'd3;

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        byte_count <= 0;
        done <= 1'b0;
    end else begin
        case (state)
            STATE_WAIT: begin
                if (in[3]) begin
                    state <= STATE_BYTE1;
                    byte_count <= 1;
                end else begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                end
                done <= 1'b0;
            end
            STATE_BYTE1: begin
                if (byte_count == 1) begin
                    state <= STATE_BYTE2;
                    byte_count <= 2;
                end else begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                end
                done <= 1'b0;
            end
            STATE_BYTE2: begin
                if (byte_count == 2) begin
                    state <= STATE_BYTE3;
                    byte_count <= 3;
                end else begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                end
                done <= 1'b0;
            end
            STATE_BYTE3: begin
                if (byte_count == 3) begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                    done <= 1'b1;
                end else begin
                    state <= STATE_WAIT;
                    byte_count <= 0;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= STATE_WAIT;
                byte_count <= 0;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
