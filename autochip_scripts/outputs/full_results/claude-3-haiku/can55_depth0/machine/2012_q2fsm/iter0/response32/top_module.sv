module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (w) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= D;
                end
            end
            C: begin
                if (w) begin
                    state <= E;
                end
                else begin
                    state <= D;
                end
            end
            D: begin
                if (w) begin
                    state <= F;
                end
                else begin
                    state <= A;
                end
            end
            E: begin
                if (w) begin
                    state <= E;
                end
                else begin
                    state <= D;
                end
            end
            F: begin
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= D;
                end
            end
        endcase
    end
end

always @* begin
    z = (state == E) | (state == F);
end

endmodule
