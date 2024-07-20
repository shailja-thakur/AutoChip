module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam [1:0] IDLE = 2'b00, SHIFT = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;
reg [1:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counter <= 2'b00;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        counter <= (state == SHIFT) ? counter - 1 : counter;
        shift_ena <= (state == SHIFT);
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = (reset) ? SHIFT : IDLE;
        SHIFT: next_state = (counter == 2'b00) ? DONE : SHIFT;
        DONE: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

endmodule
