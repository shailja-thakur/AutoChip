module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter [1:0] INIT = 2'b00, CALC = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;
reg [7:0] result;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= INIT;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        INIT: begin
            z = 1'b0;
            result = 8'b0;
            count = 4'b0;
            if (~x)
                next_state = CALC;
            else
                next_state = INIT;
        end
        CALC: begin
            result = {result[6:0], x};
            count = count + 1;
            if (count == 4'd7) begin
                next_state = DONE;
                z = ~result[7] ? result : (~result + 1);
            end
            else
                next_state = CALC;
        end
        DONE: begin
            z = ~result[7] ? result : (~result + 1);
            if (areset)
                next_state = INIT;
            else
                next_state = DONE;
        end
        default: begin
            next_state = INIT;
        end
    endcase
end

endmodule
