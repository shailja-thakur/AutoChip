module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock) begin
        // Logic for output p
        if (a)
            p <= 1;
        else
            p <= 0;
    end
    
    always @(negedge clock) begin
        // Logic for output q
        if (a)
            q <= 0;
        else
            q <= 1;
    end

endmodule
