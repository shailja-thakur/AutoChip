module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

always @(posedge clock) begin
    case ({a, p, q})
        3'b000: {p, q} = 2'b00;
        3'b001: {p, q} = 2'b00;
        3'b010: {p, q} = 2'b00;
        3'b011: {p, q} = 2'b00;
        3'b100: {p, q} = 2'b00;
        3'b101: {p, q} = 2'b00;
        3'b110: {p, q} = 2'b01;
        3'b111: {p, q} = 2'b10;
    endcase
end

endmodule
