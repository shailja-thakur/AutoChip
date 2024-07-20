module top_module (
    input wire d,
    input wire ena,
    output reg q
);

    always @(posedge ena or negedge ena) begin
        if (ena) begin
            q <= d;
        end else begin
            q <= 1'b0;
        end
    end
    
endmodule
