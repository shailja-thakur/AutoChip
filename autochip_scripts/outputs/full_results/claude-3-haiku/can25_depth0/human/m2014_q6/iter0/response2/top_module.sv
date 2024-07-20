module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State variables
    reg [2:0] state;
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

    // State update logic
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
                default: state <= A;
            endcase
        end
    end

endmodule
