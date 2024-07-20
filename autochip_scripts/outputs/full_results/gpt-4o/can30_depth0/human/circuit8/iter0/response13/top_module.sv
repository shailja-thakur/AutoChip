module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    // Process triggered on the rising edge of the clock
    always @(posedge clock) begin
        p <= a;
        if (!a) begin
            q <= p;
        end
    end

endmodule
