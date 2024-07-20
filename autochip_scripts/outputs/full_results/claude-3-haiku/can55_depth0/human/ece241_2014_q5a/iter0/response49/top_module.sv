module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_IDLE = 0, STATE_COMPLEMENTING = 1;
reg state, next_state;
reg [7:0] input_reg, complement_reg;
reg [3:0] bit_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_IDLE;
        input_reg <= 0;
        complement_reg <= 0;
        bit_count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        input_reg <= {input_reg[6:0], x};
        if (state == STATE_COMPLEMENTING) begin
            complement_reg <= {complement_reg[6:0], ~x};
            bit_count <= bit_count + 1;
            if (bit_count == 7)
                z <= ~complement_reg;
        end
    end
end

always @(*) begin
    case (state)
        STATE_IDLE:
            if (!areset)
                next_state = STATE_COMPLEMENTING;
            else
                next_state = STATE_IDLE;
        STATE_COMPLEMENTING:
            if (bit_count == 7)
                next_state = STATE_IDLE;
            else
                next_state = STATE_COMPLEMENTING;
        default:
            next_state = STATE_IDLE;
    endcase
end

endmodule
