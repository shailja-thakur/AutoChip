module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    wire A, B, C, D, E, F;
    assign Y1 = y[1];
    assign Y3 = y[3];

    always @* begin
        case (y)
            6'b000001: begin // A
                A = 1'b1;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
            end
            6'b000010: begin // B
                A = 1'b0;
                B = 1'b1;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
            end
            6'b000100: begin // C
                A = 1'b0;
                B = 1'b0;
                C = 1'b1;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
            end
            6'b001000: begin // D
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b1;
                E = 1'b0;
                F = 1'b0;
            end
            6'b010000: begin // E
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b1;
                F = 1'b0;
            end
            6'b100000: begin // F
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b1;
            end
            default: begin
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
            end
        endcase
    end

endmodule
