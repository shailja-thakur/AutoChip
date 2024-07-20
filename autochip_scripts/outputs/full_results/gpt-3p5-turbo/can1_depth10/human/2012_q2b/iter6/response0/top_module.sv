module top_module (
    input [5:0] y,
    input w,
    output reg Y1 = 1'b0,
    output reg Y3 = 1'b0
);

reg [5:0] next_y;

always @(posedge w) begin
    case(y)
        6'b000001: begin // A
            next_y <= 6'b000010; // Next state B
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
        6'b000010: begin // B
            next_y <= 6'b000100; // Next state C
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
        6'b000100: begin // C
            next_y <= 6'b001000; // Next state D
            Y1 <= 1'b0;
            Y3 <= 1'b1;
        end
        6'b001000: begin // D
            next_y <= 6'b010000; // Next state E
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
        6'b010000: begin // E
            next_y <= 6'b100000; // Next state F
            Y1 <= 1'b1;
            Y3 <= 1'b0;
        end
        6'b100000: begin // F
            next_y <= 6'b000001; // Next state A
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
        default: begin
            next_y <= 6'b000001; // Next state A
            Y1 <= 1'b0;
            Y3 <= 1'b0;
        end
    endcase
end

always @(posedge w) begin
    y <= next_y;
end

endmodule
