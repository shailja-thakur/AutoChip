module top_module (
    input a,
    input b,
    output reg q
);

always @(*) begin
    if ((a == 0) && (b == 1)) begin
        q = 0;
    end
    else if ((a == 1) && (b == 0)) begin
        q = 0;
    end
    else if ((a == 1) && (b == 1)) begin
        q = 1;
    end
    else begin
        q = 0;
    end
end

endmodule
