module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] WAIT_1 = 2'b00,
                 WAIT_10 = 2'b01,
                 WAIT_101 = 2'b10,
                 FOUND = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_1;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == FOUND)
            start_shifting <= 1'b1;
    end
end

always @(*) begin
    case (state)
        WAIT_1: begin
            if (data == 1'b1)
                next_state = WAIT_10;
            else
                next_state = WAIT_1;
        end
        WAIT_10: begin
            if (data == 1'b0)
                next_state = WAIT_101;
            else
                next_state = WAIT_1;
        end
        WAIT_101: begin
            if (data == 1'b1)
                next_state = FOUND;
            else
                next_state = WAIT_1;
        end
        FOUND: begin
            next_state = FOUND;
        end
        default: begin
            next_state = WAIT_1;
        end
    endcase
end

endmodule
