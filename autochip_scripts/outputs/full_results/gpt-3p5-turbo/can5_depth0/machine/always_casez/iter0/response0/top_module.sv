module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

// Always block triggered whenever any of the inputs change
always @(in) begin
    // Case statement to compare value of input "in"
    casez(in)
        // Set output "pos" to 3'b0 if input "in" is 8'bzzzzzzz1
        8'bzzzzzzz1 : pos = 3'b0;
        
        // Set output "pos" to 3'b1 if input "in" is 8'bzzzzzz10
        8'bzzzzzz10 : pos = 3'b1;
        
        // Set output "pos" to 3'b3 if input "in" is 8'bzzzzz100
        8'bzzzzz100 : pos = 3'b3;
        
        // Set output "pos" to 3'b7 if input "in" is 8'bzzzz1000
        8'bzzzz1000 : pos = 3'b7;
        
        // Set output "pos" to 3'b6 if input "in" is 8'bz1zzzzzz
        8'bz1zzzzzz : pos = 3'b6;
        
        // Set output "pos" to 3'b5 if input "in" is 8'b10zzzzzz
        8'b10zzzzzz : pos = 3'b5;
        
        // Set output "pos" to 3'b4 if input "in" is 8'b0zzzzzzz
        8'b0zzzzzzz : pos = 3'b4;
        
        // Set output "pos" to 3'b2 if input "in" is 8'b100zzzzz
        8'b100zzzzz : pos = 3'b2;
        
        // Set output "pos" to 3'b0 if none of the above cases match
        default : pos = 3'b0;
    endcase
end

endmodule
