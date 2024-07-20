module top_module (
    input wire clk,
    input wire d,
    input wire ar,
    output logic q
);

    always @(posedge clk or posedge ar) begin
        if(ar) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end

endmodule
