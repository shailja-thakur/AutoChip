module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock or negedge clock) begin
        if (clock) begin
            // On the positive edge of the clock
            if (a == 1'b1) begin
                p <= 1'b1;
            end
            else begin
                p <= 1'b0;
            end
        end
        else begin
            // On the negative edge of the clock
            if (clock == 1'b0) begin
                q <= p;
            end
        end
    end

endmodule
