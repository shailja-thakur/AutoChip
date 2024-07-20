module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter WAIT_FIRST = 2'b00, WAIT_SECOND = 2'b01, WAIT_THIRD = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FIRST;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_FIRST: begin
                if (in[3]) begin
                    state <= WAIT_SECOND;
                end
                else begin
                    state <= WAIT_FIRST;
                end
                done <= 1'b0;
            end
            WAIT_SECOND: begin
                state <= WAIT_THIRD;
                done <= 1'b0;
            end
            WAIT_THIRD: begin
                done <= 1'b1;
                state <= WAIT_FIRST;
            end
            default: begin
                state <= WAIT_FIRST;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
