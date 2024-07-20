module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

always @ (y, w) begin
    case(y)
        6'b000001: begin // State A
            Y1 <= w;
            Y3 <= 0;
        end
        6'b000010: begin // State B
            Y1 <= w;
            Y3 <= 0;
        end
        6'b000100: begin // State C
            Y1 <= w;
            Y3 <= 0;
        end
        6'b001000: begin // State D
            Y1 <= w;
            Y3 <= 0;
        end
        6'b010000: begin // State E
            Y1 <= 0;
            Y3 <= 1;
        end
        6'b100000: begin // State F
            Y1 <= 0;
            Y3 <= 1;
        end
        default: begin
            Y1 <= 0;
            Y3 <= 0;
        end
    endcase
end

endmodule
