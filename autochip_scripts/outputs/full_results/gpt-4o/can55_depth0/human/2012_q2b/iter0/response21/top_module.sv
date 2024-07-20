module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State Encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    always @(*) begin
        case(y)
            A: begin
                Y1 = w;        // y[1] (B) if input is 1
                Y3 = 1'b0;     // y[3] (D) is not possible directly from y (A)
            end
            B: begin
                Y1 = 1'b0;     // y[1] (B) is not possible
                Y3 = ~w;       // y[3] (D) if input is 0
            end
            C: begin
                Y1 = 1'b0;     // y[1] (B) is not possible
                Y3 = ~w;       // y[3] (D) if input is 0
            end
            D: begin
                Y1 = 1'b0;     // y[1] (B) is not possible
                Y3 = ~w & 1'b1; // y[3] (D) if input is 0
            end
            E: begin
                Y1 = 1'b0;     // y[1] (B) is not possible
                Y3 = ~w;       // y[3] (D) if input is 0
            end
            F: begin
                Y1 = 1'b0;     // y[1] (B) is not possible
                Y3 = ~w;       // y[3] if input is 0
            end
            default: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
        endcase
    end

endmodule
