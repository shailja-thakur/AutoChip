module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [3:0] state;
    parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 0;
        end
        else begin
            case (state)
                A: begin
                    if (w) state <= A;
                    else state <= B;
                end
                B: begin
                    if (w) state <= D;
                    else state <= C;
                end
                C: begin
                    if (w) state <= D;
                    else state <= E;
                end
                D: begin
                    if (w) state <= A;
                    else state <= F;
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
            endcase
        end
    end

endmodule
