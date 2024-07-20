module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    always @(posedge clock) 
        q <= a;
    
    always @(posedge clock or posedge a) 
        if (clock)
            p <= a;
        else
            p <= p;

endmodule
