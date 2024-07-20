module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

// Initializing out and valid outputs
always @(code) begin
    out = 4'b0000;
    valid = 1'b1;
    
    // Assigning the output based on the value of code
    case(code)
        8'h45: out = 4'b0000; // Assigning out as 0 when code is 8'h45
        8'h16: out = 4'b0001; // Assigning out as 1 when code is 8'h16
        8'h1e: out = 4'b0010; // Assigning out as 2 when code is 8'h1e
        8'h26: out = 4'b0011; // Assigning out as 3 when code is 8'h26
        8'h25: out = 4'b0100; // Assigning out as 4 when code is 8'h25
        8'h2e: out = 4'b0101; // Assigning out as 5 when code is 8'h2e
        8'h36: out = 4'b0110; // Assigning out as 6 when code is 8'h36
        8'h3d: out = 4'b0111; // Assigning out as 7 when code is 8'h3d
        8'h3e: out = 4'b1000; // Assigning out as 8 when code is 8'h3e
        8'h46: out = 4'b1001; // Assigning out as 9 when code is 8'h46
        default: valid = 1'b0; // Assigning valid as 0 for any unmatched code 
    endcase
end

endmodule
