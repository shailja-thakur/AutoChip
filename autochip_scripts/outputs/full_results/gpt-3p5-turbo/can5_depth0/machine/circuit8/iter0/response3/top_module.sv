module top_module (
    input wire clock,
    input wire a, 
    output reg p,
    output reg q
);

    always @(negedge clock) begin
        q <= a;
    end
    
    always @(posedge clock or a) begin
        if (clock)
            p <= a;
    end
    
endmodule
