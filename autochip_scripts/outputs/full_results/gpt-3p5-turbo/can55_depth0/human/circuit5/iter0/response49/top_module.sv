module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @*
begin
    case({a,b,c,d,e})
        {4'b0000, 4'b0101} : q = b; // 15ns
        {4'b0001, 4'b0101} : q = e; // 20ns
        {4'b0010, 4'b0101} : q = a; // 25ns
        {4'b0011, 4'b0101} : q = d; // 30ns
        {4'b0100, 4'b0101} : q = f; // 35ns
        {4'b0101, 4'b0101} : q = f; // 40ns
        {4'b0110, 4'b0101} : q = f; // 45ns
        {4'b0111, 4'b0101} : q = f; // 50ns
        {4'b1000, 4'b0101} : q = f; // 55ns
        {4'b1001, 4'b0101} : q = f; // 60ns
        {4'b1010, 4'b0101} : q = f; // 65ns
        {4'b1011, 4'b0101} : q = f; // 70ns
        {4'b1100, 4'b0101} : q = f; // 75ns
        {4'b1101, 4'b0101} : q = f; // 80ns
        {4'b1110, 4'b0101} : q = f; // 85ns
        {4'b1111, 4'b0101} : q = f; // 90ns
        default : q = 4'bxxxx; // default value for q
    endcase
      
end

endmodule
