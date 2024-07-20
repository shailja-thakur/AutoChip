module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] 
    WAIT_FOR_1 = 2'b00,
    WAIT_FOR_0 = 2'b01,
    WAIT_FOR_1_AGAIN = 2'b10,
    WAIT_FOR_0_AGAIN = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= WAIT_FOR_1;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        WAIT_FOR_1: begin
            if (data == 1'b1)
                next_state = WAIT_FOR_0;
            else
                next_state = WAIT_FOR_1;
        end
        WAIT_FOR_0: begin
            if (data == 1'b0)
                next_state = WAIT_FOR_1_AGAIN;
            else
                next_state = WAIT_FOR_0;
        end
        WAIT_FOR_1_AGAIN: begin
            if (data == 1'b1)
                next_state = WAIT_FOR_0_AGAIN;
            else
                next_state = WAIT_FOR_1_AGAIN;
        end
        WAIT_FOR_0_AGAIN: begin
            if (data == 1'b0)
                next_state = WAIT_FOR_1;
            else
                next_state = WAIT_FOR_0_AGAIN;
        end
        default:
            next_state = WAIT_FOR_1;
    endcase
end

always @(posedge clk) begin
    if (reset)
        start_shifting <= 1'b0;
    else if (state == WAIT_FOR_0_AGAIN)
        start_shifting <= 1'b1;
end

endmodule
