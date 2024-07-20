module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg prev_a;
    reg prev_clock;

    always @(posedge clock or negedge clock) begin
        if (clock == 1) begin
            if (a == 1)
                p <= 1;
            else
                p <= 0;
        
            q <= q; // Retains previous state if no changes
        end else begin
            q <= p;
        end
    end

endmodule
