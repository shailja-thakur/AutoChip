module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    always @(posedge clock or posedge a) begin
        if (a) begin
            p <= 1;
        end else begin
            p <= 0;
        end
    end
    
    always @(negedge clock or posedge a) begin
        if (a) begin
            q <= 0;
        end else if (!p) begin
            q <= p;
        end else begin
            q <= 1;
        end
    end

endmodule
