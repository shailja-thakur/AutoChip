module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
);

    reg [3:0] sr; // 4-bit shift register

    always @(posedge clk) begin
        if (~resetn) begin // Reset to all zeros
            sr <= 4'b0000;
        end
        else begin // Shift left and load input
            sr <= {sr[2:0], in};
        end
    end

    assign out = sr[3]; // Output is most significant bit

endmodule
