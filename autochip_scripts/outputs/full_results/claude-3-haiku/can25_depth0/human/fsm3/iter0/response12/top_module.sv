module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

localparam [1:0]
    A = 2'b00,
    B = 2'b01,
    C = 2'b10,
    D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            out = 1'b0;
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            out = 1'b0;
            if (in)
                next_state = B;
            else
                next_state = C;
        end
        C: begin
            out = 1'b0;
            if (in)
                next_state = D;
            else
                next_state = A;
        end
        D: begin
            out = 1'b1;
            if (in)
                next_state = B;
            else
                next_state = C;
        end
    endcase
end

endmodule
