module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

// Implement the combinational logic to generate the desired output q
// Based on the provided simulation waveforms

assign q = (a & ~b & ~c & ~d) |
          (~a & ~b & c & ~d) |
          (~a & ~b & c & d) |
          (~a & b & ~c & ~d) |
          (~a & b & ~c & d) |
          (~a & b & c & ~d) |
          (~a & b & c & d) |
          (a & ~b & ~c & d) |
          (a & ~b & c & ~d) |
          (a & ~b & c & d) |
          (a & b & ~c & ~d) |
          (a & b & ~c & d) |
          (a & b & c & ~d) |
          (a & b & c & d);

endmodule
