module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    reg Y2;
    reg Y4;

    always @(*) begin
        Y2 = ~w & y[1];
        Y4 = w & y[6] & y[5] & y[3] & y[2];
    end
   
    assign Y2 = Y2;
    assign Y4 = Y4;
 
endmodule
