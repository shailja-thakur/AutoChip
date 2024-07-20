module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [3:0] state;
parameter A = 4'd0, B = 4'd1, C = 4'd2, D = 4'd3, E = 4'd4, F = 4'd5;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (w) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            B: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
            end
            C: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
            end
            D: begin
                if (w) begin
                    state <= A;
                end
                else begin
                    state <= F;
                end
            end
            E: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= E;
                end
            end
            F: begin
                if (w) begin
                    state <= D;
                end
                else begin
                    state <= C;
                end
            end
        endcase
    end
end

assign z = (state == E) || (state == F);

endmodule
