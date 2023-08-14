module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out );

    // Insert your code here

    always @(sel or a or b) begin
        out <= sel ? b : a;
    end

endmodule