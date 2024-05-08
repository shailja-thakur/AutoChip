module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );

    reg [99:0] sum;
    reg [99:0] carry;

    always @(posedge clk) begin
        if (reset) begin
            sum <= 0;
            carry <= 0;
        end else begin
            sum <= a + b + carry;
            carry <= (a > b) ? 1 : 0;
        end
    end

    assign cout = carry[99];

endmodule