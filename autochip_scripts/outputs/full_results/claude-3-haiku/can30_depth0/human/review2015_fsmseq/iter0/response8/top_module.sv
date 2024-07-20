module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00,
                 FOUND_1 = 2'b01,
                 FOUND_10 = 2'b10,
                 FOUND_101 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (state == FOUND_101) begin
            start_shifting <= 1;
        end
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1) begin
                next_state = FOUND_1;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_1: begin
            if (data == 0) begin
                next_state = FOUND_10;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_10: begin
            if (data == 1) begin
                next_state = FOUND_101;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_101: begin
            next_state = FOUND_101;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
