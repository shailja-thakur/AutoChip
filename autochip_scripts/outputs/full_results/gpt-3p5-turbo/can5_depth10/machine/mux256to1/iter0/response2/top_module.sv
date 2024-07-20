module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);
    reg [255:0] selected_bit;  // register to hold the selected bit
    
    always @(*) begin
        selected_bit = in[sel];  // select the bit from the input vector based on the selection vector
    end
    
    assign out = selected_bit;  // assign the selected bit to the output
    
endmodule
