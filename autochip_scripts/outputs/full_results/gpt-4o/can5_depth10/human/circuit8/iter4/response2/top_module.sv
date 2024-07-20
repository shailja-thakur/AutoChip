module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    always @(posedge clock or negedge clock) begin
        if (clock) begin
            if (a) begin
                p <= 1;
            end else begin
                p <= 0;
            end
        end
    end
    
    always @(posedge clock or negedge clock) begin
        if (~clock) begin
            if (a) begin
                q <= 0;
            end else begin
                q <= p;
            end
        end
    end

endmodule
