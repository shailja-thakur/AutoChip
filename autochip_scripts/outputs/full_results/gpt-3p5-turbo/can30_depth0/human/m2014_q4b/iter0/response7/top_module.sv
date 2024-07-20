module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);
    always @(posedge clk or negedge ar) begin
        if (ar == 0) begin
            q <= 0; // asynchronous reset
        end else begin
            q <= d; // positive edge triggered
        end
    end
endmodule
