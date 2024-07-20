module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    case ({a, q})
        2'b00: begin
            p <= 0;
            q <= 0;
        end
        2'b01: begin
            p <= 0;
            q <= 1;
        end
        2'b10: begin
            p <= 0;
            q <= 0;
        end
        2'b11: begin
            p <= 1;
            q <= 1;
        end
    endcase
end

endmodule
