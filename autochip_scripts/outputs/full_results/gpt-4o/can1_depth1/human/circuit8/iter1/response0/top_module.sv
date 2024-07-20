module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock or negedge clock) begin
        if (clock) begin
            // p follows 'a' on the rising edge of the clock
            p <= a;
        end else begin
            // q follows 'p' on the falling edge of the clock
            q <= p;
        end
    end

endmodule
