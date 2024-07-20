module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(*) begin
    case (sel)
        0: out = in[3:0];
        1: out = in[7:4];
        2: out = in[11:8];
        //... continue for all the possible selections
        
        default: out = 4'b0; // Default case
    endcase
end

endmodule
