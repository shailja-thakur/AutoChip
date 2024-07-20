module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, CONVERT = 2'b01, COMPLETE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] num, complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        num <= {num[6:0], x};
        if (state == CONVERT)
            complement <= ~num + 1;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (areset) ? IDLE : CONVERT;
            z = 0;
        end
        CONVERT: begin
            next_state = (areset) ? COMPLETE : CONVERT;
            z = complement[0];
        end
        COMPLETE: begin
            next_state = IDLE;
            z = complement[0];
        end
        default: begin
            next_state = IDLE;
            z = 0;
        end
    endcase
end

endmodule
