module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [3:0] out;

always @(*) begin
    case (sel)
        0: out = in[3:0];
        1: out = in[7:4];
        2: out = in[11:8];
        // Add more cases for the remaining selections
        // 3: out = in[15:12];
        // 4: out = in[19:16];
        // ...
        default: out = 4'b0000; // Default case, in case sel is invalid
    endcase
end

endmodule
