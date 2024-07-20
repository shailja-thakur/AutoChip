module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter WAIT_FOR_1 = 2'b00;
    parameter WAIT_FOR_1_0 = 2'b01;
    parameter WAIT_FOR_1_1 = 2'b10;
    parameter FOUND_1101 = 2'b11;

    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_1;
            start_shifting <= 1'b0;
        end
        else begin
            case (state)
                WAIT_FOR_1: begin
                    if (data) begin
                        state <= WAIT_FOR_1_0;
                    end
                    else begin
                        state <= WAIT_FOR_1;
                    end
                    start_shifting <= 1'b0;
                end
                WAIT_FOR_1_0: begin
                    if (~data) begin
                        state <= WAIT_FOR_1_1;
                    end
                    else begin
                        state <= WAIT_FOR_1;
                    end
                    start_shifting <= 1'b0;
                end
                WAIT_FOR_1_1: begin
                    if (data) begin
                        state <= FOUND_1101;
                    end
                    else begin
                        state <= WAIT_FOR_1;
                    end
                    start_shifting <= 1'b0;
                end
                FOUND_1101: begin
                    start_shifting <= 1'b1;
                    state <= FOUND_1101;
                end
            endcase
        end
    end

endmodule
