module top_module (
        input clk,
        input j,
        input k,
        output reg Q
);

always @(posedge clk)
begin
    if (j & !k) //changed from j & !Q
        Q <= 1'b1; //changed from j
    else if (!j & k) //changed from !k & Q
        Q <= 1'b0; //changed from 0
    else if (j & k)
        Q <= ~Q;
end

endmodule
