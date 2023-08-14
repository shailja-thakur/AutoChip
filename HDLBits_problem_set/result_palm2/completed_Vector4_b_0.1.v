module top_module (
    input [7:0] in,
    output [31:0] out );//

    // Insert your code below
    // assign out = { replicate-sign-bit , the-input };

    always @(posedge clk) begin
        out <= {24'b0, in};
    end

endmodule