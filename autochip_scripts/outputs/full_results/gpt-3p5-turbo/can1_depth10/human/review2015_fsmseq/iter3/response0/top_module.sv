module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [3:0] state;

    parameter IDLE = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    parameter S3 = 3;
    parameter FOUND = 4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE:
                    if (data) begin
                        state <= S1;
                    end
                S1:
                    if (data) begin
                        state <= S2;
                    end else begin
                        state <= IDLE;
                    end
                S2:
                    if (data) begin
                        state <= S3;
                    end else begin
                        state <= IDLE;
                    end
                S3:
                    if (data) begin
                        state <= FOUND;
                    end else begin
                        state <= IDLE;
                    end
                FOUND:
                    state <= IDLE;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else begin
            if (state == FOUND) begin
                start_shifting <= 1;
            end else begin
                start_shifting <= 0;
            end
        end
    end

endmodule
