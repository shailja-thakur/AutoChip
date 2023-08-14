module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
 	// Insert your code below
    // assign s = ...
    // assign overflow = ...

    always @(posedge clk) begin
        if (reset) begin
            s <= 32'h0;
            overflow <= 1'b0;
        end else begin
            s <= a + b;
            overflow <= (s[8] == 1);
        end
    end

endmodule