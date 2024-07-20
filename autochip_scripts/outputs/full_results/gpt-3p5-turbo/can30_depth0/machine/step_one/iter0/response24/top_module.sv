module top_module(
    output reg one); // Added 'reg' keyword
    always @(*) begin // Added sensitivity list
        one = 1'b1; // Assigning value to 'one'
    end
endmodule
