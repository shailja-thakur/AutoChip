module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (w == 1'b0) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            B: begin
                if (w == 1'b0) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
            end
            C: begin
                if (w == 1'b0) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
            end
            D: begin
                if (w == 1'b0) begin
                    state <= A;
                end
                else begin
                    state <= F;
                end
            end
            E: begin
                if (w == 1'b0) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
            end
            F: begin
                if (w == 1'b0) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
            end
        endcase
    end
end

always @(*) begin
    z = (state == E || state == F) ? 1'b1 : 1'b0;
end

endmodule
