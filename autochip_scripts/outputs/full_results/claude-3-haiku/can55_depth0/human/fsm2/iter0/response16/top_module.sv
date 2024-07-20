module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

localparam [1:0] OFF = 2'b00, ON = 2'b01;
reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= OFF;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        OFF: begin
            if (j)
                next_state = ON;
            else
                next_state = OFF;
            out = 1'b0;
        end
        ON: begin
            if (k)
                next_state = OFF;
            else
                next_state = ON;
            out = 1'b1;
        end
        default: begin
            next_state = OFF;
            out = 1'b0;
        end
    endcase
end

endmodule
