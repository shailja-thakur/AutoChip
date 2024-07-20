module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;

reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= A;
    else begin
        case (state)
            A: begin
                if (x)
                    state <= C;
                else
                    state <= A;
            end
            B: state <= x ? B : C;
            C: state <= x ? B : C;
        endcase
    end
end

assign z = (state == C);

endmodule
