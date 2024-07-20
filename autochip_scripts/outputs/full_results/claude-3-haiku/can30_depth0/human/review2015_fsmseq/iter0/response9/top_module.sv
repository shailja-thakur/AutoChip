module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam IDLE = 3'd0;
localparam SEARCH_1 = 3'd1;
localparam SEARCH_10 = 3'd2;
localparam SEARCH_101 = 3'd3;
localparam FOUND = 3'd4;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            start_shifting = 1'b0;
            if (data == 1'b1)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
        end
        SEARCH_1: begin
            start_shifting = 1'b0;
            if (data == 1'b1)
                next_state = SEARCH_10;
            else
                next_state = IDLE;
        end
        SEARCH_10: begin
            start_shifting = 1'b0;
            if (data == 1'b0)
                next_state = SEARCH_101;
            else
                next_state = IDLE;
        end
        SEARCH_101: begin
            start_shifting = 1'b0;
            if (data == 1'b1)
                next_state = FOUND;
            else
                next_state = IDLE;
        end
        FOUND: begin
            start_shifting = 1'b1;
            next_state = FOUND;
        end
        default: begin
            start_shifting = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
