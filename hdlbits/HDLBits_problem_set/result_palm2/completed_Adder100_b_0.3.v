module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );

    function [99:0] add(input [99:0] a, input [99:0] b, input cin);
        reg [99:0] sum;
        for (i = 0; i < 100; i++) begin
            sum[i] = a[i] + b[i] + cin;
            if (sum[i] >= 2) begin
                sum[i] -= 2;
                cin = 1;
            else
                cin = 0;
        end
    endfunction

    assign sum = add(a, b, cin);
    assign cout = sum[99];

endmodule