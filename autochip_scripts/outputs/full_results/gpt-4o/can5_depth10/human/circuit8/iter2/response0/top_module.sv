module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock or negedge clock) begin
        if (clock) begin
            // On the rising edge of the clock
            if (a == 1) begin
                p <= 1;
            end else begin
                p <= 0;
            end
        end else begin
            // On the falling edge of the clock
            if (a == 1) begin
                q <= 0;
            end else begin
                q <= p;
            end
        end
    end
endmodule
