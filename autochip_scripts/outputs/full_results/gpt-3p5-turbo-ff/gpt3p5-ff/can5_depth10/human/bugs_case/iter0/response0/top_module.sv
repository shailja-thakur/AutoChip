module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

// Define the cases
parameter [7:0] CASES [9:0] = {
    8'h45, 8'h16, 8'h1e, 8'h26, 8'h25, 8'h2e, 8'h36, 8'h3d, 8'h3e, 8'h46
};

// Flag to indicate if a match is found
reg match_found;

always @(*) begin
    // Set default values
    out = 4'b0000;
    valid = 1'b0;
    match_found = 0;
  
    // Compare input code with each case
    for (int i = 0; i < 10; i = i + 1) begin
        if (code == CASES[i]) begin
            out = i;
            valid = 1'b1;
            match_found = 1;
            break;
        end
    end
  
    // No match found
    if (match_found == 0) begin
        out = 4'b0000;
        valid = 1'b0;
    end
end

endmodule
