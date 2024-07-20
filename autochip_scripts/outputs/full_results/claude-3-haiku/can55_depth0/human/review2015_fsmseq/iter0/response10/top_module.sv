module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [3:0] IDLE = 4'd0,
                 S1   = 4'd1,
                 S11  = 4'd2,
                 S110 = 4'd3,
                 S1101= 4'd4;

reg [3:0] state, next_state;

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
                next_state = S1;
            else
                next_state = IDLE;
        end
        S1: begin
            if (data == 1'b1)
                next_state = S11;
            else
                next_state = IDLE;
        end
        S11: begin
            if (data == 1'b0)
                next_state = S110;
            else
                next_state = S1;
        end
        S110: begin
            if (data == 1'b1)
                next_state = S1101;
            else
                next_state = IDLE;
        end
        S1101: begin
            next_state = S1101;
        end
        default:
            next_state = IDLE;
    endcase
end

always @(posedge clk) begin
    if (reset)
        start_shifting <= 1'b0;
    else if (state == S1101)
        start_shifting <= 1'b1;
end

endmodule
