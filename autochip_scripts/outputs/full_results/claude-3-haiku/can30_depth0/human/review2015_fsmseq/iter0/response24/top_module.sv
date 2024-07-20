module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [1:0] state;
parameter IDLE = 2'b00, FOUND_1 = 2'b01, FOUND_11 = 2'b10, FOUND_110 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    state <= FOUND_1;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            FOUND_1: begin
                if (data == 1'b0)
                    state <= FOUND_11;
                else
                    state <= FOUND_1;
                start_shifting <= 1'b0;
            end
            FOUND_11: begin
                if (data == 1'b0)
                    state <= FOUND_110;
                else
                    state <= FOUND_1;
                start_shifting <= 1'b0;
            end
            FOUND_110: begin
                if (data == 1'b1)
                    state <= FOUND_1;
                else
                    state <= IDLE;
                start_shifting <= 1'b1;
            end
            default:
                state <= IDLE;
        endcase
    end
end

endmodule
