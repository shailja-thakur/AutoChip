module top_module (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [3:0] state;
    reg [3:0] next_state;

    parameter IDLE = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    parameter S3 = 3;
    parameter FOUND = 4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            IDLE:
                if (data) begin
                    next_state = S1;
                end else begin
                    next_state = IDLE;
                end
            S1:
                if (data) begin
                    next_state = S2;
                end else begin
                    next_state = IDLE;
                end
            S2:
                if (data) begin
                    next_state = S3;
                end else begin
                    next_state = IDLE;
                end
            S3:
                if (data) begin
                    next_state = FOUND;
                end else begin
                    next_state = IDLE;
                end
            FOUND:
                next_state = IDLE;
        endcase
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
