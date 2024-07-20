module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT_FIRST = 2'd0;
localparam STATE_WAIT_SECOND = 2'd1;
localparam STATE_WAIT_THIRD = 2'd2;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_FIRST;
        done <= 0;
    end else begin
        case (state)
            STATE_WAIT_FIRST: begin
                if (in[3]) begin
                    state <= STATE_WAIT_SECOND;
                end
            end
            STATE_WAIT_SECOND: begin
                state <= STATE_WAIT_THIRD;
            end
            STATE_WAIT_THIRD: begin
                done <= 1;
                state <= STATE_WAIT_FIRST;
            end
        endcase
    end
end

endmodule
