module top_module (
    input clk,
    input areset,
    input x,
    output z
);

localparam STATE_A = 2'd0;
localparam STATE_B = 2'd1;

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= STATE_A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        STATE_A: begin
            if (x)
                next_state = STATE_B;
            else
                next_state = STATE_A;
            z = x;
        end
        STATE_B: begin
            next_state = STATE_B;
            z = ~x;
        end
        default: begin
            next_state = STATE_A;
            z = 0;
        end
    endcase
end

endmodule
