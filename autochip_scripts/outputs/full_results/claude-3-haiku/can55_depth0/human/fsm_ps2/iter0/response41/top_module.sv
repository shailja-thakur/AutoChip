module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter [1:0] IDLE = 2'd0, RECV1 = 2'd1, RECV2 = 2'd2, RECV3 = 2'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= RECV1;
                end
                else begin
                    state <= IDLE;
                end
                done <= 1'b0;
            end
            RECV1: begin
                state <= RECV2;
                done <= 1'b0;
            end
            RECV2: begin
                state <= RECV3;
                done <= 1'b0;
            end
            RECV3: begin
                state <= IDLE;
                done <= 1'b1;
            end
            default: begin
                state <= IDLE;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
