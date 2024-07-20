module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter INIT = 0, CONVERT = 1;
reg state, next_state;
reg [7:0] num, complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= INIT;
        num <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        num <= {num[6:0], x};
        complement <= {complement[6:0], ~x};
        z <= (state == CONVERT) ? complement[0] : 0;
    end
end

always @(*) begin
    case (state)
        INIT: begin
            next_state = (areset) ? INIT : CONVERT;
        end
        CONVERT: begin
            next_state = (areset) ? INIT : CONVERT;
        end
        default: begin
            next_state = INIT;
        end
    endcase
end

endmodule
