module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Implementation of a 255-bit population count circuit

// Divide and conquer approach
wire [7:0] count_1, count_2, count_3, count_4;

// Stage 1: Count 1s in first 64 bits
popcount_64 pc1 (.in(in[63:0]), .out(count_1));

// Stage 2: Count 1s in next 64 bits
popcount_64 pc2 (.in(in[127:64]), .out(count_2));

// Stage 3: Count 1s in next 64 bits
popcount_64 pc3 (.in(in[191:128]), .out(count_3));

// Stage 4: Count 1s in last 63 bits
popcount_63 pc4 (.in(in[254:192]), .out(count_4));

// Stage 5: Combine the partial counts
always @* begin
    out = count_1 + count_2 + count_3 + count_4;
end

// 64-bit population count module
module popcount_64 (
    input [63:0] in,
    output reg [7:0] out
);
  
    always @* begin
        out = $countones(in);
    end
endmodule
module popcount_63 (
    input [62:0] in,
    output reg [7:0] out
);
  
    always @* begin
        out = $countones(in);
    end
endmodule
