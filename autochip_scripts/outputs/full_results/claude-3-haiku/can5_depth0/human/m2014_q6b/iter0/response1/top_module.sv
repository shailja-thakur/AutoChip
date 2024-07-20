module top_module(
    input [3:1] y,
    input w,
    output reg Y2
);

always @(*) begin
    case (y)
        3'b000: begin // State A
            Y2 = ~w;
        end
        3'b001: begin // State B
            Y2 = 1'b0;
        end
        3'b010: begin // State C
            Y2 = 1'b0;
        end
        3'b011: begin // State D
            Y2 = w;
        end
        3'b100: begin // State E
            Y2 = 1'b1;
        end
        3'b101: begin // State F
            Y2 = ~w;
        end
        default: begin
            Y2 = 1'bx; // Invalid state
        end
    endcase
end

endmodule
