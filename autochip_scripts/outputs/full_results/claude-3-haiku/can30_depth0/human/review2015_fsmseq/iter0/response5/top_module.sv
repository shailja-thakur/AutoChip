module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [2:0] IDLE = 3'b000,
                 S1 = 3'b001,
                 S11 = 3'b011,
                 S110 = 3'b010,
                 S1101 = 3'b110;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (data == 1'b1) ? S1 : IDLE;
            start_shifting = 1'b0;
        end
        S1: begin
            next_state = (data == 1'b1) ? S11 : IDLE;
            start_shifting = 1'b0;
        end
        S11: begin
            next_state = (data == 1'b0) ? S110 : S1;
            start_shifting = 1'b0;
        end
        S110: begin
            next_state = (data == 1'b1) ? S1101 : IDLE;
            start_shifting = 1'b0;
        end
        S1101: begin
            next_state = S1101;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = IDLE;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
