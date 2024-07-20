module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else begin
        case (state)
            A: state <= (in) ? B : A;
            B: state <= (in) ? B : C;
            C: state <= (in) ? D : A;
            D: state <= (in) ? B : C;
        endcase
    end
end

always @(*) begin
    out = (state == D);
end

endmodule
