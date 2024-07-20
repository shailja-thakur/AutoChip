module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock) begin
        if (a) 
            p <= 1;
        else 
            p <= 0;
    end

    always @(negedge clock) begin
        if (a) 
            q <= 0;
        else 
            q <= p;
    end

endmodule
