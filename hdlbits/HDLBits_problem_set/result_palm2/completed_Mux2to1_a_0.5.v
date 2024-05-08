module top_module( 
    input a, b, sel,
    output out ); 

    // Insert your code here

    always @(sel or a or b) begin
        out <= sel ? b : a;
    end

endmodule