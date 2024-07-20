module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] sr;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            sr <= 4'b0000; // reset register to all zeros
        else
            sr <= {sr[2:0], in}; // shift left and load input into LSB
    end

    assign out = sr[3]; // output from MSB

endmodule
