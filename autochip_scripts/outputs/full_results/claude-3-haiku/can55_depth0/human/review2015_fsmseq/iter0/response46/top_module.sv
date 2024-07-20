module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;
parameter IDLE = 4'b0000, WAIT_1 = 4'b0001, WAIT_11 = 4'b0011, WAIT_110 = 4'b0111, FOUND = 4'b1111;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= WAIT_1;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            WAIT_1: begin
                if (data == 1'b1) begin
                    state <= WAIT_11;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            WAIT_11: begin
                if (data == 1'b0) begin
                    state <= WAIT_110;
                end
                else begin
                    state <= WAIT_1;
                end
                start_shifting <= 1'b0;
            end
            WAIT_110: begin
                if (data == 1'b1) begin
                    state <= FOUND;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            FOUND: begin
                state <= FOUND;
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
