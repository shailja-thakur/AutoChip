module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;
parameter [3:0] IDLE = 4'b0000,
                S1 = 4'b0001,
                S11 = 4'b0011,
                S110 = 4'b0111,
                S1101 = 4'b1111;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    state <= S1;
                else
                    state <= IDLE;
            end
            S1: begin
                if (data == 1'b1)
                    state <= S11;
                else
                    state <= IDLE;
            end
            S11: begin
                if (data == 1'b0)
                    state <= S110;
                else
                    state <= S1;
            end
            S110: begin
                if (data == 1'b1)
                    state <= S1101;
                else
                    state <= IDLE;
            end
            S1101: begin
                state <= S1101;
                start_shifting <= 1'b1;
            end
            default: begin
                state <= IDLE;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
