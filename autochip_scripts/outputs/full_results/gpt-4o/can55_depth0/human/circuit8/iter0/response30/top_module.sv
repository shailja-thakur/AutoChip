module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    // Sequential always block triggered on the rising edge of the clock
    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end

    // Sequential always block triggered on the falling edge of the clock
    always @(negedge clock) begin
        if (a) begin
            q <= 0;
        end else begin
            if (p == 1) begin
                q <= 1;  // latch q only if p was 1 during this clock cycle
            end else begin
                q <= 0;
            end
        end
    end

endmodule
