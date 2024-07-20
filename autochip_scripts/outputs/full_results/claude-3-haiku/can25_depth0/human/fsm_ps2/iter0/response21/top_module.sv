module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter IDLE = 2'b00, RECV1 = 2'b01, RECV2 = 2'b10, RECV3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
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
                done <= 0;
            end
            RECV1: begin
                state <= RECV2;
                done <= 0;
            end
            RECV2: begin
                state <= RECV3;
                done <= 0;
            end
            RECV3: begin
                state <= IDLE;
                done <= 1;
            end
        endcase
    end
end

endmodule
