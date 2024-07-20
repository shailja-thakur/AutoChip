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
            A: begin
                if (w == 1'b0) state <= A;
                else state <= B;
            end
            B: begin
                if (w == 1'b0) state <= D;
                else state <= C;
            end
            C: begin
                if (w == 1'b0) state <= D;
                else state <= E;
            end
            D: begin
                if (w == 1'b0) state <= A;
                else state <= F;
            end
            E: begin
                if (w == 1'b0) state <= D;
                else state <= E;
            end
            F: begin
                if (w == 1'b0) state <= D;
                else state <= C;
            end
        endcase
    end
end

assign z = (state == E) | (state == F);

endmodule
