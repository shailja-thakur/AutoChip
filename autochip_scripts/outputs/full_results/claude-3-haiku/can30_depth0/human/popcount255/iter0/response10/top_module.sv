module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Recursive function to count the number of 1's in a vector
function [7:0] count_ones;
    input [254:0] vector;
    integer i;
    begin
        count_ones = 0;
        for (i = 0; i < 255; i = i + 1) begin
            if (vector[i]) count_ones = count_ones + 1;
        end
    end
endfunction

always @(*) begin
    out = count_ones(in);
end

endmodule
