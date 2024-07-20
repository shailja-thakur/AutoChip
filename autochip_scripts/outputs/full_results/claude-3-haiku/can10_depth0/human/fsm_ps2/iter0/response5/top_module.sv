module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter [1:0] S_WAIT = 2'b00, S_RECV1 = 2'b01, S_RECV2 = 2'b10, S_RECV3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= S_WAIT;
        done <= 1'b0;
    end
    else begin
        case (state)
            S_WAIT: begin
                if (in[3]) begin
                    state <= S_RECV1;
                end
                else begin
                    state <= S_WAIT;
                end
                done <= 1'b0;
            end
            S_RECV1: begin
                state <= S_RECV2;
                done <= 1'b0;
            end
            S_RECV2: begin
                state <= S_RECV3;
                done <= 1'b0;
            end
            S_RECV3: begin
                state <= S_WAIT;
                done <= 1'b1;
            end
            default: begin
                state <= S_WAIT;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
