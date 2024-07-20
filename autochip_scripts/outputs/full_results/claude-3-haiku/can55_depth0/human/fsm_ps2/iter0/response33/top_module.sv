module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT_FIRST = 2'b00;
localparam STATE_WAIT_SECOND = 2'b01;
localparam STATE_WAIT_THIRD = 2'b10;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_FIRST;
        done <= 1'b0;
    end else begin
        case (state)
            STATE_WAIT_FIRST: begin
                if (in[3]) begin
                    state <= STATE_WAIT_SECOND;
                end else begin
                    state <= STATE_WAIT_FIRST;
                end
                done <= 1'b0;
            end
            STATE_WAIT_SECOND: begin
                state <= STATE_WAIT_THIRD;
                done <= 1'b0;
            end
            STATE_WAIT_THIRD: begin
                state <= STATE_WAIT_FIRST;
                done <= 1'b1;
            end
        endcase
    end
end

endmodule
