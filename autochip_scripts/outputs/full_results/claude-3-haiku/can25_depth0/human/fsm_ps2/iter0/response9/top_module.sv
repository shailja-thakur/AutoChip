module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam WAIT_FIRST = 0;
localparam WAIT_SECOND = 1;
localparam WAIT_THIRD = 2;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FIRST;
        done <= 0;
    end else begin
        case (state)
            WAIT_FIRST: begin
                if (in[3]) begin
                    state <= WAIT_SECOND;
                end
                done <= 0;
            end
            WAIT_SECOND: begin
                state <= WAIT_THIRD;
                done <= 0;
            end
            WAIT_THIRD: begin
                done <= 1;
                state <= WAIT_FIRST;
            end
        endcase
    end
end

endmodule
