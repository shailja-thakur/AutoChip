module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [2:0] state;
    parameter IDLE = 3'd0, FOUND_1 = 3'd1, FOUND_11 = 3'd2, FOUND_110 = 3'd3, FOUND_1101 = 3'd4;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1) begin
                        state <= FOUND_1;
                    end
                    else begin
                        state <= IDLE;
                    end
                    start_shifting <= 1'b0;
                end
                FOUND_1: begin
                    if (data == 1'b0) begin
                        state <= FOUND_11;
                    end
                    else begin
                        state <= FOUND_1;
                    end
                    start_shifting <= 1'b0;
                end
                FOUND_11: begin
                    if (data == 1'b0) begin
                        state <= FOUND_110;
                    end
                    else begin
                        state <= FOUND_1;
                    end
                    start_shifting <= 1'b0;
                end
                FOUND_110: begin
                    if (data == 1'b1) begin
                        state <= FOUND_1101;
                    end
                    else begin
                        state <= IDLE;
                    end
                    start_shifting <= 1'b0;
                end
                FOUND_1101: begin
                    state <= FOUND_1101;
                    start_shifting <= 1'b1;
                end
            endcase
        end
    end

endmodule
