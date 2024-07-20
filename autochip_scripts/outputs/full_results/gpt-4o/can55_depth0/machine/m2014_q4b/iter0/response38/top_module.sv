module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

always @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 0; // Asynchronous reset
    end else begin
        q <= d; // Register data input on clock edge
    end
end

endmodule
