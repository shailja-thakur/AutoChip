module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

always @(*) begin
    case (y)
        6'b000001: begin // state A
            Y1 = w;
            Y3 = 1'b0;
        end
        6'b000010: begin // state B
            Y1 = ~w;
            Y3 = w;
        end
        6'b000100: begin // state C
            Y1 = w;
            Y3 = ~w;
        end
        6'b001000: begin // state D
            Y1 = ~w;
            Y3 = ~w;
        end
        6'b010000: begin // state E
            Y1 = w;
            Y3 = 1'b0;
        end
        6'b100000: begin // state F
            Y1 = ~w;
            Y3 = w;
        end
        default: begin
            Y1 = 1'bx;
            Y3 = 1'bx;
        end
    endcase
end

endmodule
