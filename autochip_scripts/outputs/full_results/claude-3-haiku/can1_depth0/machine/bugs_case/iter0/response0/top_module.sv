module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

always @(*) begin
    out = 0; // Initialize output to 0
    valid = 1; // Initialize valid to 1

    case (code)
        8'h45: out = 0; // '0'
        8'h16: out = 1; // '1'
        8'h1e: out = 2; // '2'
        8'h26: out = 3; // '3'
        8'h25: out = 4; // '4'
        8'h2e: out = 5; // '5'
        8'h36: out = 6; // '6'
        8'h3d: out = 7; // '7'
        8'h3e: out = 8; // '8'
        8'h46: out = 9; // '9'
        default: valid = 0; // If code does not match any case, set valid to 0
    endcase
end

endmodule
