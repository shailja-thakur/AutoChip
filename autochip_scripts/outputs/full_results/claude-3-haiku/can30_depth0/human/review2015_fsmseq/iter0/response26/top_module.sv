module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [1:0] state;
parameter [1:0] IDLE = 2'b00, SEARCH_1 = 2'b01, SEARCH_11 = 2'b10, SEARCH_101 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1) begin
                    state <= SEARCH_1;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 0;
            end
            SEARCH_1: begin
                if (data == 1) begin
                    state <= SEARCH_11;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 0;
            end
            SEARCH_11: begin
                if (data == 0) begin
                    state <= SEARCH_101;
                end
                else begin
                    state <= SEARCH_1;
                end
                start_shifting <= 0;
            end
            SEARCH_101: begin
                if (data == 1) begin
                    state <= IDLE;
                    start_shifting <= 1; // Set start_shifting to 1 when the sequence is found
                end
                else begin
                    state <= IDLE;
                    start_shifting <= 0;
                end
            end
            default: begin
                state <= IDLE;
                start_shifting <= 0;
            end
        endcase
    end
end

endmodule
