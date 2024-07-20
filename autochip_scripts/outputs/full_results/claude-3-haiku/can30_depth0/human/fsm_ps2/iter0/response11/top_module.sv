module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter WAIT_FIRST = 2'b00, GOT_FIRST = 2'b01, GOT_SECOND = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FIRST;
        done <= 1'b0;
    end else begin
        case (state)
            WAIT_FIRST: begin
                if (in[3]) begin
                    state <= GOT_FIRST;
                end
                done <= 1'b0;
            end
            GOT_FIRST: begin
                state <= GOT_SECOND;
                done <= 1'b0;
            end
            GOT_SECOND: begin
                state <= WAIT_FIRST;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT_FIRST;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
