module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00;
parameter CALC = 2'b01;
parameter DONE = 2'b11;

reg [1:0] state, next_state;
reg [7:0] accum;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            z = 0;
            next_state = (x) ? CALC : IDLE;
            accum = 0;
            count = 0;
        end
        CALC: begin
            z = ~accum[0];
            next_state = (count == 7) ? DONE : CALC;
            accum = {accum[6:0], x};
            count = count + 1;
        end
        DONE: begin
            z = ~accum[0];
            next_state = (x) ? DONE : IDLE;
            accum = 0;
            count = 0;
        end
        default: begin
            z = 0;
            next_state = IDLE;
            accum = 0;
            count = 0;
        end
    endcase
end

endmodule
