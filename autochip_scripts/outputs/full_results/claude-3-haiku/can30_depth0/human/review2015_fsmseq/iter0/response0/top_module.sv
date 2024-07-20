module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter IDLE = 3'd0;
parameter SEARCH_1 = 3'd1;
parameter SEARCH_2 = 3'd2;
parameter SEARCH_3 = 3'd3;
parameter FOUND = 3'd4;

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= SEARCH_1;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            SEARCH_1: begin
                if (data == 1'b1) begin
                    state <= SEARCH_2;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            SEARCH_2: begin
                if (data == 1'b0) begin
                    state <= SEARCH_3;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            SEARCH_3: begin
                if (data == 1'b1) begin
                    state <= FOUND;
                end
                else begin
                    state <= IDLE;
                end
                start_shifting <= 1'b0;
            end
            FOUND: begin
                state <= FOUND;
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
