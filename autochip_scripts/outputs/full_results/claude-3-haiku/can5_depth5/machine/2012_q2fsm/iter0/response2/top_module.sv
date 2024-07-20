module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else begin
        case (state)
            A: state <= (w == 1'b0) ? A : B;
            B: state <= (w == 1'b0) ? D : C;
            C: state <= (w == 1'b0) ? D : E;
            D: state <= (w == 1'b0) ? A : F;
            E: state <= (w == 1'b0) ? D : E;
            F: state <= (w == 1'b0) ? D : C;
            default: state <= A;
        endcase
    end
end

assign z = (state == E) | (state == F);

endmodule
