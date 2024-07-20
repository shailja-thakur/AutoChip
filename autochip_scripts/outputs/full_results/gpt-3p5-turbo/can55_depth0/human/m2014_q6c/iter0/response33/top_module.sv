module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

reg Y2;
reg Y4;

always @(*) begin
    case (y)
        7'b000001: begin // state A
            Y2 = 1'b0;
            Y4 = 1'b0;
        end
        7'b000010: begin // state B
            Y2 = 1'b0;
            Y4 = 1'b1;
        end
        7'b000100: begin // state C
            Y2 = 1'b1;
            Y4 = 1'b0;
        end
        7'b001000: begin // state D
            Y2 = 1'b1;
            Y4 = 1'b1;
        end
        7'b010000: begin // state E
            Y2 = 1'b0;
            Y4 = 1'b1;
        end
        7'b100000: begin // state F
            Y2 = 1'b1;
            Y4 = 1'b0;
        end
        default: begin
            Y2 = 1'b0;
            Y4 = 1'b0;
        end
    endcase
end

endmodule
