module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (w) state <= B;
                else state <= A;
            end
            B: begin
                if (w) state <= C;
                else state <= D;
            end
            C: begin
                if (w) state <= E;
                else state <= D;
            end
            D: begin
                if (w) state <= F;
                else state <= A;
            end
            E: begin
                if (w) state <= E;
                else state <= D;
            end
            F: begin
                if (w) state <= C;
                else state <= D;
            end
        endcase
    end
end

always @* begin
    z = (state == E || state == F) ? 1'b1 : 1'b0;
end

endmodule
