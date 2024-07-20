module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

always @(posedge w) begin
    case(y)
        6'b000001: begin // A
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
        6'b000010: begin // B
            Y1 <= 1'b1;
            Y3 <= 1'b0;
        end
        6'b000100: begin // C
            Y1 <= 1'b1;
            Y3 <= 1'b0;
        end
        6'b001000: begin // D
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
        6'b010000: begin // E
            Y1 <= 1'b0;
            Y3 <= 1'b1;
        end
        6'b100000: begin // F
            Y1 <= 1'b1;
            Y3 <= 1'b0;
        end
        default: begin
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
    endcase
end

endmodule
