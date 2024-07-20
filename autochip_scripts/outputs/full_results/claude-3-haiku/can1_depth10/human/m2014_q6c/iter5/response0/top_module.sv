module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

always @(*) begin
    case (y)
        6'b000001: begin // State A
            Y2 = w;
            Y4 = 1'b0;
        end
        6'b000010: begin // State B
            Y2 = 1'b0;
            Y4 = w;
        end
        6'b000100: begin // State C
            Y2 = w;
            Y4 = 1'b0;
        end
        6'b001000: begin // State D
            Y2 = 1'b0;
            Y4 = 1'b0;
        end
        6'b010000: begin // State E
            Y2 = 1'b0;
            Y4 = w;
        end
        6'b100000: begin // State F
            Y2 = 1'b0;
            Y4 = w;
        end
        default: begin
            Y2 = 1'b0;
            Y4 = 1'b0;
        end
    endcase
end

endmodule
