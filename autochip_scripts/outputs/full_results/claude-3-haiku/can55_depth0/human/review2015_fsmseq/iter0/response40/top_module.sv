module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00, SHIFT1 = 2'b01, SHIFT2 = 2'b10, SHIFT3 = 2'b11;
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
            if (data == 1'b1)
                next_state = SHIFT1;
            else
                next_state = IDLE;
        end
        SHIFT1: begin
            start_shifting = 1'b0;
            if (data == 1'b0)
                next_state = SHIFT2;
            else
                next_state = IDLE;
        end
        SHIFT2: begin
            start_shifting = 1'b0;
            if (data == 1'b1)
                next_state = SHIFT3;
            else
                next_state = IDLE;
        end
        SHIFT3: begin
            start_shifting = 1'b1;
            next_state = SHIFT3;
        end
        default: begin
            start_shifting = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
