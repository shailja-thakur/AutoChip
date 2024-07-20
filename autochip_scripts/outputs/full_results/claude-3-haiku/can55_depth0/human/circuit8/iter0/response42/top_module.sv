module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    case ({a, p, q})
        3'b000: begin
            p <= 0;
            q <= 0;
        end
        3'b001: begin
            p <= 0;
            q <= 1;
        end
        3'b010: begin
            p <= 0;
            q <= 1;
        end
        3'b011: begin
            p <= 1;
            q <= 1;
        end
        3'b100: begin
            p <= 0;
            q <= 0;
        end
        3'b101: begin
            p <= 1;
            q <= 0;
        end
        3'b110: begin
            p <= 1;
            q <= 0;
        end
        3'b111: begin
            p <= 1;
            q <= 1;
        end
    endcase
end

endmodule
