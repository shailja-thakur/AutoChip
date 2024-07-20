module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11, E = 3'b100, F = 3'b101;

    reg [2:0] state;

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
            endcase
        end
    end

endmodule
