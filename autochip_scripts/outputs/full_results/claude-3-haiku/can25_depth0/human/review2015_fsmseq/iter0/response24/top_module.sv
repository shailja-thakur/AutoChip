module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [2:0] state;
parameter [2:0] IDLE = 3'b000, FIND_1 = 3'b001, FIND_10 = 3'b010, FIND_101 = 3'b011, FIND_1101 = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1)
                    state <= FIND_1;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            FIND_1: begin
                if (data == 1'b0)
                    state <= FIND_10;
                else
                    state <= FIND_1;
                start_shifting <= 1'b0;
            end
            FIND_10: begin
                if (data == 1'b1)
                    state <= FIND_101;
                else
                    state <= IDLE;
                start_shifting <= 1'b0;
            end
            FIND_101: begin
                if (data == 1'b0)
                    state <= FIND_1101;
                else
                    state <= FIND_1;
                start_shifting <= 1'b0;
            end
            FIND_1101: begin
                state <= FIND_1101;
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
