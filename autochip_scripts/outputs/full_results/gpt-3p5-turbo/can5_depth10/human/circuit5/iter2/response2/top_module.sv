module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @(*) begin
    case ({a, b, c, d, e})
        // time            a               b               c               d               e               q               
        // 0ns             x               x               x               x               x               x               
        // 5ns             x               x               x               x               x               x               
        // 10ns            x               x               x               x               x               x               
        // 15ns            a               b               0               d               e               b               
        // 20ns            a               b               1               d               e               e               
        // 25ns            a               b               2               d               e               a               
        // 30ns            a               b               3               d               e               d               
        // 35ns            a               b               4               d               e               f               
        // 40ns            a               b               5               d               e               f               
        // 45ns            a               b               6               d               e               f               
        // 50ns            a               b               7               d               e               f               
        // 55ns            a               b               8               d               e               f               
        // 60ns            a               b               9               d               e               f               
        // 65ns            a               b               a               d               e               f               
        // 70ns            a               b               b               d               e               f               
        // 75ns            a               b               c               d               e               f               
        // 80ns            a               b               d               d               e               f               
        // 85ns            a               b               e               d               e               f               
        // 90ns            a               b               f               d               e               f               
        5'b0000 : q = 4'b1011;
        5'b0001 : q = 4'b1110;
        5'b0010 : q = 4'b0001;
        5'b0011 : q = 4'b1101;
        5'b0100 : q = 4'b1111;
        5'b0101 : q = 4'b1111;
        5'b0110 : q = 4'b1111;
        5'b0111 : q = 4'b1111;
        5'b1000 : q = 4'b1111;
        5'b1001 : q = 4'b1111;
        5'b1010 : q = 4'b1111;
        5'b1011 : q = 4'b1111;
        5'b1100 : q = 4'b1111;
        5'b1101 : q = 4'b1111;
        5'b1110 : q = 4'b1111;
        default: q = 4'b1111;
    endcase
end

endmodule
