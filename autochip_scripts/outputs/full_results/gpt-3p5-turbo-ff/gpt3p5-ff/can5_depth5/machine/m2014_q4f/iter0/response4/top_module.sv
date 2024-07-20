module top_module (
    input in1,
    input in2,
    output logic out
);
    
    // Perform logical operations on input signals to produce output signal
    always_comb begin
        if (in1 && !in2) begin
            out = 1'b1;
        end
        else begin
            out = 1'b0;
        end
    end
    
endmodule
