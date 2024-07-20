module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00, FOUND_1 = 2'b01, FOUND_11 = 2'b10, FOUND_110 = 2'b11;
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
            if (data == 1'b1)
                next_state = FOUND_1;
            else
                next_state = IDLE;
            start_shifting = 1'b0;
        end
        FOUND_1: begin
            if (data == 1'b1)
                next_state = FOUND_11;
            else
                next_state = IDLE;
            start_shifting = 1'b0;
        end
        FOUND_11: begin
            if (data == 1'b0)
                next_state = FOUND_110;
            else
                next_state = FOUND_1;
            start_shifting = 1'b0;
        end
        FOUND_110: begin
            if (data == 1'b1)
                next_state = FOUND_1;
            else
                next_state = IDLE;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = IDLE;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
