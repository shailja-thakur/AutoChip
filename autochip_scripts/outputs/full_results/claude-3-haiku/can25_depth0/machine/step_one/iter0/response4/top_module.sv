module top_module(
    output reg one
);

    // Assign the output one to a constant logic high value
    always @(*) begin
        one = 1'b1;
    end

endmodule
