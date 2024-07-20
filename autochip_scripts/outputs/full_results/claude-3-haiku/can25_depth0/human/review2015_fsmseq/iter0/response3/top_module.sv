module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;
parameter WAIT_FOR_1 = 4'b0000,
          WAIT_FOR_0 = 4'b0001,
          WAIT_FOR_1_AGAIN = 4'b0010,
          WAIT_FOR_0_AGAIN = 4'b0011,
          FOUND_1101 = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_1;
        start_shifting <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_1: begin
                if (data) begin
                    state <= WAIT_FOR_0;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
            end
            WAIT_FOR_0: begin
                if (~data) begin
                    state <= WAIT_FOR_1_AGAIN;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
            end
            WAIT_FOR_1_AGAIN: begin
                if (data) begin
                    state <= WAIT_FOR_0_AGAIN;
                end
                else begin
                    state <= WAIT_FOR_1_AGAIN;
                end
            end
            WAIT_FOR_0_AGAIN: begin
                if (~data) begin
                    state <= FOUND_1101;
                    start_shifting <= 1;
                end
                else begin
                    state <= WAIT_FOR_1;
                end
            end
            FOUND_1101: begin
                start_shifting <= 1;
            end
        endcase
    end
end

endmodule
