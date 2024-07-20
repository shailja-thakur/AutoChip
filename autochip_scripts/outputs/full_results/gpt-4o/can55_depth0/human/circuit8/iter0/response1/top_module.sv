module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);
    reg previous_a;

    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end
    
    always @(negedge clock) begin
        q <= p;
    end

    initial begin
        p = 0;
        q = 0;
    end
endmodule
