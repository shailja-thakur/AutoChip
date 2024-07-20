module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define the states
    parameter IDLE = 2'd0;
    parameter FOUND_1 = 2'd1;
    parameter FOUND_11 = 2'd2;
    parameter FOUND_101 = 2'd3;

    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            start_shifting <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1) begin
                        state <= FOUND_1;
                    end else begin
                        state <= IDLE;
                    end
                    start_shifting <= 0;
                end
                FOUND_1: begin
                    if (data == 1'b0) begin
                        state <= FOUND_11;
                    end else begin
                        state <= IDLE;
                    end
                    start_shifting <= 0;
                end
                FOUND_11: begin
                    if (data == 1'b0) begin
                        state <= FOUND_101;
                    end else begin
                        state <= IDLE;
                    end
                    start_shifting <= 0;
                end
                FOUND_101: begin
                    if (data == 1'b1) begin
                        state <= FOUND_1;
                        start_shifting <= 1;
                    end else begin
                        state <= IDLE;
                        start_shifting <= 0;
                    end
                end
            endcase
        end
    end

endmodule
