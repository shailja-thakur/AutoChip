module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam A = 2'b01;
localparam B = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (x == 0)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (x == 0)
                next_state = B;
            else
                next_state = B;
        end
        default:
            next_state = A;
    endcase
end

always @(*) begin
    case (state)
        A: begin
            if (x == 0)
                z = 0;
            else
                z = 1;
        end
        B: begin
            if (x == 0)
                z = 1;
            else
                z = 0;
        end
        default:
            z = 0;
    endcase
end

endmodule
