module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT_FIRST = 0;
localparam STATE_RECEIVE_SECOND = 1;
localparam STATE_RECEIVE_THIRD = 2;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_FIRST;
        done <= 1'b0;
    end
    else begin
        case (state)
            STATE_WAIT_FIRST: begin
                if (in[3]) begin
                    state <= STATE_RECEIVE_SECOND;
                end
                done <= 1'b0;
            end
            STATE_RECEIVE_SECOND: begin
                state <= STATE_RECEIVE_THIRD;
            end
            STATE_RECEIVE_THIRD: begin
                state <= STATE_WAIT_FIRST;
                done <= 1'b1;
            end
        endcase
    end
end

endmodule
