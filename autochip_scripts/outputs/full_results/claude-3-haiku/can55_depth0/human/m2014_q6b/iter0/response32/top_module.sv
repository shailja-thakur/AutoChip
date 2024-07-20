module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000, 3'b011, 3'b101: begin // A, D, F
            Y2 = w;
        end
        3'b001: begin // B
            Y2 = ~w;
        end
        3'b010: begin // C
            Y2 = 1'b0;
        end
        3'b100: begin // E
            Y2 = 1'b1;
        end
        default: begin
            Y2 = 1'bx; // Handle any undefined state
        end
    endcase
end

endmodule
