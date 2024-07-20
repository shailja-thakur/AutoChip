module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg prev_a;
reg temp;

always @(posedge clock) begin
    prev_a <= a;
    
    if (a == 1'b1 && prev_a == 1'b0) begin
        temp <= 1'b1;
    end else if (a == 1'b0 && prev_a == 1'b1) begin
        temp <= 1'b0;
    end
end

always @(posedge clock) begin
    if (temp == 1'b1) begin
        p <= 1'b1;
        q <= 1'b0;
    end else begin
        p <= 1'b0;
        q <= 1'b1;
    end
end
    
endmodule
