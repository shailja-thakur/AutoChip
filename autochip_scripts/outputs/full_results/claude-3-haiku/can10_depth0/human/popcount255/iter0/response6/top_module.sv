module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Recursive population count function
function [7:0] popcount;
    input [254:0] vector;
    begin
        if (vector == 0)
            popcount = 0;
        else
            popcount = (vector[0] ? 1 : 0) + popcount(vector[254:1]);
    end
endfunction

always @(*) begin
    out = popcount(in);
end

endmodule
