module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam A = 2'b01; // state A
localparam B = 2'b10; // state B

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (x == 1'b0)
                next_state = A;
            else
                next_state = B;
            z = x;
        end
        B: begin
            next_state = B;
            z = ~x;
        end
        default: begin
            next_state = A;
            z = 1'b0;
        end
    endcase
end

endmodule
