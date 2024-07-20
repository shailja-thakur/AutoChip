module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00, SEARCH_1 = 2'b01, SEARCH_0 = 2'b10, FOUND = 2'b11;
reg [1:0] state, next_state;

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
    next_state = state;
    case (state)
        IDLE: begin
            if (data == 1'b1)
                next_state = SEARCH_1;
        end
        SEARCH_1: begin
            if (data == 1'b1)
                next_state = SEARCH_0;
            else
                next_state = IDLE;
        end
        SEARCH_0: begin
            if (data == 1'b0)
                next_state = SEARCH_0;
            else
                next_state = IDLE;
        end
        FOUND: begin
            start_shifting <= 1'b1;
        end
    endcase

    if (state == SEARCH_0 && data == 1'b0)
        next_state = FOUND;
end

endmodule
