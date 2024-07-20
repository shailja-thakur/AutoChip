module top_module (
    input clk,
    input in,
    output logic out
);

reg d;
always @(posedge clk)
begin
    d <= in ^ out;
end

always @(posedge clk)
begin
    out <= d;
end

initial
begin
    $display("Hello, World!");

    clk = 0;
    in = 0;
    #5;
    
    for (int i = 0; i < 10; i = i + 1)
    begin
        #10;
        in = ~in;
    end
    
    $finish;
end

endmodule
