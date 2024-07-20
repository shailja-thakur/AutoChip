module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter WAIT_START = 2'd0;
parameter FIRST_BYTE = 2'd1;
parameter SECOND_BYTE = 2'd2;
parameter THIRD_BYTE = 2'd3;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (in[3]) begin
                    state <= FIRST_BYTE;
                end
                else begin
                    state <= WAIT_START;
                end
                done <= 1'b0;
            end
            FIRST_BYTE: begin
                state <= SECOND_BYTE;
                done <= 1'b0;
            end
            SECOND_BYTE: begin
                state <= THIRD_BYTE;
                done <= 1'b0;
            end
            THIRD_BYTE: begin
                state <= WAIT_START;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT_START;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
