module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock or negedge clock) begin
        if (!clock) begin
            q <= p;
        end else if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end
    
    always @(negedge clock) begin
        if (a) begin
            q <= 1;
        end else begin
            q <= 0;
        end
    end

endmodule
