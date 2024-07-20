module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00, SEARCH_1 = 2'b01, SEARCH_11 = 2'b10, SEARCH_101 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            start_shifting = 1'b0;
            if (data)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
        end
        SEARCH_1: begin
            start_shifting = 1'b0;
            if (data)
                next_state = SEARCH_11;
            else
                next_state = IDLE;
        end
        SEARCH_11: begin
            start_shifting = 1'b0;
            if (~data)
                next_state = SEARCH_101;
            else
                next_state = SEARCH_1;
        end
        SEARCH_101: begin
            start_shifting = 1'b1;
            next_state = SEARCH_101;
        end
        default:
            next_state = IDLE;
    endcase
end

endmodule
