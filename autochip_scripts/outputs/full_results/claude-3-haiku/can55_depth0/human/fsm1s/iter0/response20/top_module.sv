module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg state, next_state;

localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_B;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_B: begin
            out = 1'b1;
            if (in == 1'b0) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
        end
        STATE_A: begin
            out = 1'b0;
            if (in == 1'b0) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
        end
        default: begin
            out = 1'b0;
            next_state = STATE_B;
        end
    endcase
end

endmodule
