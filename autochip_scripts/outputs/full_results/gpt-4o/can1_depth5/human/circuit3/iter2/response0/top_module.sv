module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);
    // Determine the output 'q' based on the waveform table:
    // Notice that q = 1 when:
    // - (b==1 and (c==1 or d==1))
    // - (a==1 and d==1)
    // Combine these conditions together logically

    always @(*) begin
        if (b == 1) begin
            if (c == 1 || d == 1)
                q = 1;
            else
                q = 0;
        end
        else if (a == 1) begin
            if (d == 1)
                q = 1;
            else
                q = 0;
        end
        else
            q = 0;
    end
endmodule
