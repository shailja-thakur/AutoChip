module top_module(
    output reg one // Added 'reg' datatype for the output 'one'
);

always @(*) begin
    one = 1'b1; // Assigned the value of 1'b1 to 'one'
end

endmodule
