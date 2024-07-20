module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'd0,
                 SEARCH_1 = 2'd1,
                 SEARCH_0 = 2'd2,
                 SEARCH_1_1 = 2'd3;

reg [1:0] current_state, next_state;

always @(posedge clk) begin
    if (reset)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

always @(*) begin
    next_state = current_state;
    case (current_state)
        IDLE: begin
            if (data == 1'b1)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
        end
        SEARCH_1: begin
            if (data == 1'b0)
                next_state = SEARCH_0;
            else
                next_state = SEARCH_1;
        end
        SEARCH_0: begin
            if (data == 1'b1)
                next_state = SEARCH_1_1;
            else
                next_state = IDLE;
        end
        SEARCH_1_1: begin
            if (data == 1'b1)
                next_state = SEARCH_1_1;
            else
                next_state = IDLE;
        end
    endcase
end

always @(posedge clk) begin
    if (reset)
        start_shifting <= 1'b0;
    else if (current_state == SEARCH_1_1)
        start_shifting <= 1'b1;
end

endmodule
