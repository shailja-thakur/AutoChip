module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

always_ff @(posedge clk or posedge ar) begin
    if (ar) begin
        q <= 1'b0; // reset the output to 0
    end else begin
        q <= d; // assign d to the output on positive clock edge
    end
end

endmodule
