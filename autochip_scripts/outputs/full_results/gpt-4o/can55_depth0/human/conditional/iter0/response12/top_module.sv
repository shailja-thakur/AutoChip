module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    wire [7:0] min_ab, min_cd;
    
    // Compare a and b
    assign min_ab = (a < b) ? a : b;

    // Compare c and d
    assign min_cd = (c < d) ? c : d;

    // Find the minimum value between min_ab and min_cd
    always @(*) begin
        min = (min_ab < min_cd) ? min_ab : min_cd;
    end

endmodule
