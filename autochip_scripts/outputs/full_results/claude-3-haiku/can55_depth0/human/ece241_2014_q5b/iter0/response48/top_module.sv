module top_module (
    input clk,
    input areset,
    input x,
    output z
);

localparam [1:0] A = 2'b01, B = 2'b10;
reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A:
            if (x == 0)
                next_state = A;
            else
                next_state = B;
        B:
            if (x == 0)
                next_state = B;
            else
                next_state = B;
        default:
            next_state = A;
    endcase
end

assign z = (state == B) & x;

endmodule
