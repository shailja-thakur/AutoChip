module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);

always @(*) begin
    // Default values
    out = 4'b0000;
    valid = 1'b1;

    case (code)
        8'h45: out = 4'b0000; // Key '0'
        8'h16: out = 4'b0001; // Key '1'
        8'h1E: out = 4'b0010; // Key '2'
        8'h26: out = 4'b0011; // Key '3'
        8'h25: out = 4'b0100; // Key '4'
        8'h2E: out = 4'b0101; // Key '5'
        8'h36: out = 4'b0110; // Key '6'
        8'h3D: out = 4'b0111; // Key '7'
        8'h3E: out = 4'b1000; // Key '8'
        8'h46: out = 4'b1001; // Key '9'
        default: valid = 1'b0; // Invalid key
    endcase
end

endmodule
