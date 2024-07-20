module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);
    always @(posedge clock or negedge clock) begin
        if (clock) begin
            if (a) p <= 1;
            else p <= 0;
        end
        else begin
            q <= p;
        end
    end
endmodule
