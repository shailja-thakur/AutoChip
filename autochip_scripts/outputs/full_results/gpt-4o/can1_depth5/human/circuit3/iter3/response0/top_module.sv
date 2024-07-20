module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);
    always @(*) begin
        // Implementing the logic based on the given waveforms
        q = (b & (c | d)) | (a & d);
    end
endmodule
