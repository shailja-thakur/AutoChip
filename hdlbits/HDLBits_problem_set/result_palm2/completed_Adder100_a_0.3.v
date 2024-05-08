module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );

    wire [99:0] carry;

    always @(posedge clk) begin
        carry <= cin;
        for (int i = 99; i >= 0; i--) begin
            sum[i] <= a[i] + b[i] + carry;
            carry <= (a[i] & b[i]) | (carry & (a[i] | b[i]));
        end
    end

    assign cout = carry[99];

endmodule