module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;

reg [1:0] state;

always @(posedge clk or areset)
begin
    if (areset)
        state <= A;
    else
    begin
        case (state)
            A: state <= (x)? C : A;
            B: state <= (x)? B : C;
            C: state <= (x)? B : C;
            default: state <= A;
        endcase
    end
end

assign z = (state == C) ? 1'b1 : 1'b0;

endmodule
