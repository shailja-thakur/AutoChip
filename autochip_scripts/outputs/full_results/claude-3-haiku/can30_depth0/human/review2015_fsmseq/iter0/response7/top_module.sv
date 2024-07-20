module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [1:0] state;
parameter IDLE = 2'b00, FOUND_1 = 2'b01, FOUND_11 = 2'b10, FOUND_1101 = 2'b11;

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
                    state <= FOUND_1101;
                end else begin
                    state <= IDLE;
                end
                start_shifting <= 0;
            end
            FOUND_1101: begin
                state <= FOUND_1101;
                start_shifting <= 1;
            end
            default: begin
                state <= IDLE;
                start_shifting <= 0;
            end
        endcase
    end
end

endmodule
