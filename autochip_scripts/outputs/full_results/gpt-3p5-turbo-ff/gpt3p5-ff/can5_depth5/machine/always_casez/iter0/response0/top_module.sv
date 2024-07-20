module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @*
begin
    casez(in)
        8'bzzzzzzz1: pos = 3'b0;
        8'bz1zzzzzz: pos = 3'b6;
        //... add more cases here as needed
        default: pos = 3'b0;
    endcase
end

endmodule
