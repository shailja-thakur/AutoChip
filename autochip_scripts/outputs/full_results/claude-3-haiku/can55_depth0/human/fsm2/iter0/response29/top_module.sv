module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

localparam OFF = 1'b0, ON = 1'b1;
reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= OFF;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        OFF: begin
            if (j == 1'b0)
                next_state = OFF;
            else
                next_state = ON;
        end
        ON: begin
            if (k == 1'b0)
                next_state = ON;
            else
                next_state = OFF;
        end
        default:
            next_state = OFF;
    endcase
    
    out = state;
end

endmodule
