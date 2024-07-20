module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Create a cascade of adders to count the population
reg [7:0] count1, count2, count3, count4, count5;

always @(*) begin
    // First layer of 16 8-bit adders
    count1 = {1'b0, in[15:0]}  + {1'b0, in[31:16]} + {1'b0, in[47:32]} + {1'b0, in[63:48]} +
             {1'b0, in[79:64]} + {1'b0, in[95:80]} + {1'b0, in[111:96]} + {1'b0, in[127:112]} +
             {1'b0, in[143:128]} + {1'b0, in[159:144]} + {1'b0, in[175:160]} + {1'b0, in[191:176]} +
             {1'b0, in[207:192]} + {1'b0, in[223:208]} + {1'b0, in[239:224]} + {1'b0, in[254:240]};

    // Second layer of 4 16-bit adders
    count2 = {1'b0, count1[15:0]} + {1'b0, count1[31:16]} + {1'b0, count1[47:32]} + {1'b0, count1[63:48]};
    count3 = {1'b0, count1[79:64]} + {1'b0, count1[95:80]} + {1'b0, count1[111:96]} + {1'b0, count1[127:112]};
    count4 = {1'b0, count1[143:128]} + {1'b0, count1[159:144]} + {1'b0, count1[175:160]} + {1'b0, count1[191:176]};
    count5 = {1'b0, count1[207:192]} + {1'b0, count1[223:208]} + {1'b0, count1[239:224]} + {1'b0, count1[254:240]};

    // Final layer of 1 32-bit adder
    out = count2 + count3 + count4 + count5;
end

endmodule
