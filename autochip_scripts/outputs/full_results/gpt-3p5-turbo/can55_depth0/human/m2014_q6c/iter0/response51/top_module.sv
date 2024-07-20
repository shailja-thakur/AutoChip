module top_module (
    input [6:1] y,
    input w,
    output logic Y2,
    output logic Y4
);

    always_comb begin
        case (y)
            7'b000001: begin
                Y2 = 0;
                Y4 = 0;
            end
            7'b000010: begin
                Y2 = 0;
                Y4 = 1;
            end
            7'b000100: begin
                Y2 = 1;
                Y4 = 0;
            end
            7'b001000: begin
                Y2 = 1;
                Y4 = 1;
            end
            7'b010000: begin
                Y2 = 0;
                Y4 = 0;
            end
            7'b100000: begin
                Y2 = 1;
                Y4 = 1;
            end
            default: begin
                Y2 = 0;
                Y4 = 0;
            end
        endcase
    end

endmodule
