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
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (w) state <= A;
                else state <= B;
                z <= 0;
            end
            B: begin
                if (w) state <= D;
                else state <= C;
                z <= 0;
            end
            C: begin
                if (w) state <= D;
                else state <= E;
                z <= 0;
            end
            D: begin
                if (w) state <= A;
                else state <= F;
                z <= 0;
            end
            E: begin
                if (w) state <= D;
                else state <= E;
                z <= 1;
            end
            F: begin
                if (w) state <= D;
                else state <= C;
                z <= 1;
            end
            default: state <= A;
        endcase
    end
end

endmodule
