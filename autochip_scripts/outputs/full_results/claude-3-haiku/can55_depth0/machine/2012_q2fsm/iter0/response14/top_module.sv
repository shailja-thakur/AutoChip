module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else begin
        case (state)
            A: state <= (w == 0) ? A : B;
            B: state <= (w == 0) ? D : C;
            C: state <= (w == 0) ? D : E;
            D: state <= (w == 0) ? A : F;
            E: state <= (w == 0) ? D : E;
            F: state <= (w == 0) ? D : C;
        endcase
    end
end

always @(*) begin
    z = (state == E || state == F);
end

endmodule
