module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam WAIT_FOR_FIRST = 2'b00;
localparam WAIT_FOR_SECOND = 2'b01;
localparam WAIT_FOR_THIRD = 2'b10;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_FIRST;
        done <= 1'b0;
    end else begin
        case (state)
            WAIT_FOR_FIRST: begin
                if (in[3]) begin
                    state <= WAIT_FOR_SECOND;
                end
                done <= 1'b0;
            end
            WAIT_FOR_SECOND: begin
                state <= WAIT_FOR_THIRD;
                done <= 1'b0;
            end
            WAIT_FOR_THIRD: begin
                done <= 1'b1;
                state <= WAIT_FOR_FIRST;
            end
            default: begin
                state <= WAIT_FOR_FIRST;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
