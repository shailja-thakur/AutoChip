module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr;   // 4-bit register

    always @(posedge clk) begin
        if (!resetn) begin
            sr <= 4'b0000;   // reset to all zeros
        end else begin
            sr <= {sr[2:0], in};   // shift left and load input
        end
    end

    assign out = sr[3];   // output from most significant bit

endmodule
