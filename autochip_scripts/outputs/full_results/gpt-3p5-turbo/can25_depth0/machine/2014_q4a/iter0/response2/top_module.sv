module top_module (
    input wire clk,
    input wire w,
    input wire R,
    input wire E,
    input wire L,
    output reg Q
);

always @(posedge clk)
begin
    if(E)
    begin
        if(L)
            Q <= R;
        else
            Q <= w;
    end
end

endmodule
