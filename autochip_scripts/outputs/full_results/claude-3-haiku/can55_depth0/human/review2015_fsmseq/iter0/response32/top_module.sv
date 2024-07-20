module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00, FOUND_1 = 2'b01, FOUND_11 = 2'b10, FOUND_110 = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == FOUND_110) begin
            start_shifting <= 1'b1;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = FOUND_1;
            end
        end
        FOUND_1: begin
            if (data == 1'b1) begin
                next_state = FOUND_11;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_11: begin
            if (data == 1'b0) begin
                next_state = FOUND_110;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_110: begin
            next_state = FOUND_110;
        end
    endcase
end

endmodule
