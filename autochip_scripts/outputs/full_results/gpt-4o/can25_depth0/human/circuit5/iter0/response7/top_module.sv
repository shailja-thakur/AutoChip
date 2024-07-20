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
            4'd0: q = b; // 0               -> b               
            4'd1: q = e; // 1               -> e               
            4'd2: q = a; // 2               -> a               
            4'd3: q = d; // 3               -> d               
            default: q = 4'hf; // all other values -> f 
        endcase
    end
endmodule
