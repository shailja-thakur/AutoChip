module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam IDLE = 0, CONVERT = 1;
reg state, next_state;
reg [7:0] input_bits, complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_bits <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        input_bits <= {input_bits[6:0], x};
        complement <= {complement[6:0], ~x};
        if (state == CONVERT)
            z <= complement[7];
        else
            z <= 0;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = x ? CONVERT : IDLE;
        CONVERT: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

endmodule
