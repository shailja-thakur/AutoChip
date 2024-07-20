module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg current_state, next_state;

localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_B;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            if (in) begin
                next_state = STATE_A;
            end
            else begin
                next_state = STATE_B;
            end
            out = 1'b0;
        end
        STATE_B: begin
            if (in) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
            out = 1'b1;
        end
        default: begin
            next_state = STATE_B;
            out = 1'b0;
        end
    endcase
end

endmodule
