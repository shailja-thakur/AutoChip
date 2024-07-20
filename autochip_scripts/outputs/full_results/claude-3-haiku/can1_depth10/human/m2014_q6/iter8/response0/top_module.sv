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
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (w) begin
                    state <= A;
                    z <= 0;
                end
                else begin
                    state <= B;
                    z <= 0;
                end
            end
            B: begin
                if (w) begin
                    state <= D;
                    z <= 0;
                end
                else begin
                    state <= C;
                    z <= 0;
                end
            end
            C: begin
                if (w) begin
                    state <= D;
                    z <= 0;
                end
                else begin
                    state <= E;
                    z <= 0;
                end
            end
            D: begin
                if (w) begin
                    state <= A;
                    z <= 0;
                end
                else begin
                    state <= F;
                    z <= 0;
                end
            end
            E: begin
                if (w) begin
                    state <= D;
                    z <= 1;
                end
                else begin
                    state <= E;
                    z <= 1;
                end
            end
            F: begin
                if (w) begin
                    state <= D;
                    z <= 0;
                end
                else begin
                    state <= C;
                    z <= 1;
                end
            end
            default: begin
                state <= A;
                z <= 0;
            end
        endcase
    end
end

endmodule
