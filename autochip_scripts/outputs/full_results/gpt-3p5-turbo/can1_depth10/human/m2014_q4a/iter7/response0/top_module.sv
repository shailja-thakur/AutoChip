module top_module (
    input d,
    input ena,
    output reg q
);

    always @(posedge ena) begin
        if (ena) begin
            q <= d;
        end
        else begin
            q <= 1'b0;
        end
    end
    
endmodule
