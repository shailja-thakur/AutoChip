module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg last_clock;

    always @(posedge clock or posedge a) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end

    always @(posedge clock or negedge a) begin
        if (a) begin
            q <= 0;
        end else if (clock && !last_clock) begin
            q <= p;
        end
        last_clock <= clock;
    end
endmodule
