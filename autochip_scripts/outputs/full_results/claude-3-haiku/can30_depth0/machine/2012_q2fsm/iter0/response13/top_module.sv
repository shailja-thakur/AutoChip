module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
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

always @* begin
    z = (state == E) | (state == F);
end

endmodule
