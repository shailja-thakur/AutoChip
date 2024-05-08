module top_module ( 
    input wire [2:0] vec,
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  ); // Module body starts after module declaration

// Insert your code here

    always @(posedge clk) begin
        outv <= vec;
        o2 <= vec[2];
        o1 <= vec[1];
        o0 <= vec[0];
    end

endmodule