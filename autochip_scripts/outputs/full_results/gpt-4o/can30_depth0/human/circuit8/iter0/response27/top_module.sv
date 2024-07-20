module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg prev_clock;

always @(posedge clock or negedge clock) begin
    if (clock == 1 && prev_clock == 0) begin
        p <= a;
    end else if (clock == 0 && prev_clock == 1) begin
        q <= p;
    end
    prev_clock <= clock;
end

endmodule
