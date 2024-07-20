module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);
    always @(*) begin
        case (c)
            4'd0: q = b;  // 15ns
            4'd1: q = e;  // 20ns
            4'd2: q = a;  // 25ns
            4'd3: q = d;  // 30ns
            default: q = 4'hf;  // for all other cases, including 4'd4 to 4'd15 (35ns to 90ns)
        endcase
    end
endmodule
