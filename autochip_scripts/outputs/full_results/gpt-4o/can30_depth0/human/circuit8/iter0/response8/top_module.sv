module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock) begin
        p <= a; // p tracks the value of a at the rising edge of the clock
    end

    always @(negedge clock) begin
        q <= p; // q tracks the value of p at the falling edge of the clock
    end

endmodule
