module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: state <= (w) ? B : A;
            B: state <= (w) ? C : D;
            C: state <= (w) ? E : D;
            D: state <= (w) ? F : A;
            E: state <= (w) ? E : D;
            F: state <= (w) ? C : D;
        endcase
    end
end

always @(*) begin
    z = (state == E || state == F);
end

endmodule
