module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    full_adder fa[99:0];

    always @(posedge clk) begin
        for (i = 99; i >= 0; i--) begin
            sum[i] = a[i] + b[i] + cin;
            cout[i] = fa[i].cout;
        end
    end

endmodule