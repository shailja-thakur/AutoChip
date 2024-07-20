module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter INIT = 3'b000;
parameter SEARCH_1 = 3'b001;
parameter SEARCH_10 = 3'b010;
parameter SEARCH_101 = 3'b011;
parameter FOUND = 3'b100;

reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= INIT;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            INIT: begin
                if (data == 1'b1) begin
                    state <= SEARCH_1;
                end
                else begin
                    state <= INIT;
                end
                start_shifting <= 1'b0;
            end
            SEARCH_1: begin
                if (data == 1'b1) begin
                    state <= SEARCH_10;
                end
                else begin
                    state <= INIT;
                end
                start_shifting <= 1'b0;
            end
            SEARCH_10: begin
                if (data == 1'b0) begin
                    state <= SEARCH_101;
                end
                else begin
                    state <= INIT;
                end
                start_shifting <= 1'b0;
            end
            SEARCH_101: begin
                if (data == 1'b1) begin
                    state <= FOUND;
                end
                else begin
                    state <= INIT;
                end
                start_shifting <= 1'b0;
            end
            FOUND: begin
                state <= FOUND;
                start_shifting <= 1'b1;
            end
            default: begin
                state <= INIT;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
