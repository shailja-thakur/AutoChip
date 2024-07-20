module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam [1:0] IDLE = 2'd0, SHIFT = 2'd1;
reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= IDLE;
        count <= 2'd0;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        count <= (state == SHIFT) ? count + 1'b1 : 2'd0;
        shift_ena <= (state == SHIFT && count < 2'd3) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = SHIFT;
        SHIFT: next_state = (count == 2'd3) ? IDLE : SHIFT;
        default: next_state = IDLE;
    endcase
end

endmodule
