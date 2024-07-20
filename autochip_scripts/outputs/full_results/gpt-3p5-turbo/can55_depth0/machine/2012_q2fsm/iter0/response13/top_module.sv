module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
parameter [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else begin
        case (state)
            A: if (w) state <= B; else state <= A;
            B: if (w) state <= C; else state <= D;
            C: if (w) state <= E; else state <= D;
            D: if (w) state <= F; else state <= A;
            E: if (w) state <= E; else state <= D;
            F: if (w) state <= C; else state <= D;
        endcase
    end
end

assign z = (state == E) || (state == F);

endmodule
