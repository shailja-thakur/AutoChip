module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    // The process runs on the positive edge of the clock signal
    always @(posedge clock) begin
        // When a is 1, p should be set to 1
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end

    // The process runs on the negative edge of the clock signal
    always @(negedge clock) begin
        // Transfer the state of p to q on the falling edge of the clock
        q <= p;
    end

endmodule
