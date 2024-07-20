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
reg [1:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WAIT: begin
                if (in[3]) begin
                    next_state <= STATE_BYTE1;
                    done <= 0;
                end
                else begin
                    next_state <= STATE_WAIT;
                    done <= 0;
                end
            end
            STATE_BYTE1: begin
                next_state <= STATE_BYTE2;
                done <= 0;
            end
            STATE_BYTE2: begin
                next_state <= STATE_BYTE3;
                done <= 0;
            end
            STATE_BYTE3: begin
                next_state <= STATE_WAIT;
                done <= 1;
            end
        endcase
    end
end

endmodule
