module top_module(
    output reg one
);
    //Assign output one to always be 1'b1
    always @(*) begin
        one = 1'b1;
    end
endmodule
