module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @ (*) begin
        case (y)
            3'b000:
                if (w) begin
                    Y2 = 0; // A (0)
                end else begin
                    Y2 = 1; // B (0)
                end
            3'b001:
                if (w) begin
                    Y2 = 0; // A (0)
                end else begin
                    Y2 = 2; // C (0)
                end
            3'b010:
                if (w) begin
                    Y2 = 3; // D (0)
                end else begin
                    Y2 = 2; // C (0)
                end
            3'b011:
                if (w) begin
                    Y2 = 5; // F (1)
                end else begin
                    Y2 = 3; // D (0)
                end
            3'b100:
                if (w) begin
                    Y2 = 4; // E (1)
                end else begin
                    Y2 = 3; // D (0)
                end
            3'b101:
                if (w) begin
                    Y2 = 2; // C (0)
                end else begin
                    Y2 = 3; // D (0)
                end
            default:
                Y2 = 0; // Default to A (0)
        endcase
    end

endmodule
