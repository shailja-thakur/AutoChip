module top_module (
    input [99:0] in,
    output reg [99:0] out
);

    reg [99:0] temp;
  
    always_comb begin
        for (integer i = 0; i < $bits(out); i = i + 1) begin
            temp[i] = in[$bits(in) - 1 - i];
        end
        out <= temp;
    end

endmodule
