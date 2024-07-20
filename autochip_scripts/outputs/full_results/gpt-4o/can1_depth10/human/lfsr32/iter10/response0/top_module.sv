module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end else begin
        q <= {q[30] ^ q[0],    // Bit 31: XOR of bit 30 and bit 0
              q[29],           // Bit 30: Shifted from 29
              q[28],           // Bit 29: Shifted from 28
              q[27],           // Bit 28: Shifted from 27
              q[26],           // Bit 27: Shifted from 26
              q[25],           // Bit 26: Shifted from 25
              q[24],           // Bit 25: Shifted from 24
              q[23],           // Bit 24: Shifted from 23
              q[22],           // Bit 23: Shifted from 22
              q[21] ^ q[0],    // Bit 22: XOR of bit 21 and bit 0
              q[20],           // Bit 21: Shifted from 20
              q[19],           // Bit 20: Shifted from 19
              q[18],           // Bit 19: Shifted from 18
              q[17],           // Bit 18: Shifted from 17
              q[16],           // Bit 17: Shifted from 16
              q[15],           // Bit 16: Shifted from 15
              q[14],           // Bit 15: Shifted from 14
              q[13],           // Bit 14: Shifted from 13
              q[12],           // Bit 13: Shifted from 12
              q[11],           // Bit 12: Shifted from 11
              q[10],           // Bit 11: Shifted from 10
              q[9],            // Bit 10: Shifted from 9
              q[8],            // Bit 9: Shifted from 8
              q[7],            // Bit 8: Shifted from 7
              q[6],            // Bit 7: Shifted from 6
              q[5],            // Bit 6: Shifted from 5
              q[4],            // Bit 5: Shifted from 4
              q[3],            // Bit 4: Shifted from 3
              q[2],            // Bit 3: Shifted from 2
              q[1],            // Bit 2: Shifted from 1 
              q[31] ^ q[0]     // Bit 1: XOR of bit 31 and bit 0
             };
    end
end

endmodule
