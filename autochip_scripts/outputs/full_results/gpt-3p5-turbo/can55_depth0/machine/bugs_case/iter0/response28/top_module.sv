module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);

    always @(*) begin
        case(code)
            8'h02: out = 4'b0000; // Case 1
            8'h04: out = 4'b0001; // Case 2
            8'h08: out = 4'b0010; // Case 3
            8'h10: out = 4'b0011; // Case 4
            8'h20: out = 4'b0100; // Case 5
            8'h40: out = 4'b0101; // Case 6
            8'h80: out = 4'b0110; // Case 7
            default: begin
                out = 4'b0000; // Default case
                valid = 1'b0; // Invalid key
            end
        endcase
        valid = 1'b1; // Valid key
    end

endmodule
