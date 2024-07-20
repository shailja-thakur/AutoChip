module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr; // 4-bit register to store data
    
    always @(posedge clk)
    begin
        if (resetn == 0) // reset register to all zeros
            sr <= 4'b0000;
        else // shift left and load input
            sr <= {sr[2:0], in};
    end
    
    assign out = sr[3]; // output from the most significant bit
    
endmodule
