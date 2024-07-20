module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

localparam OFF = 1'b0, ON = 1'b1;
reg state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= OFF;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        OFF: begin
            out = 1'b0;
            if (j)
                next_state = ON;
            else
                next_state = OFF;
        end
        ON: begin
            out = 1'b1;
            if (k)
                next_state = OFF;
            else
                next_state = ON;
        end
        default: begin
            out = 1'b0;
            next_state = OFF;
        end
    endcase
end

endmodule
