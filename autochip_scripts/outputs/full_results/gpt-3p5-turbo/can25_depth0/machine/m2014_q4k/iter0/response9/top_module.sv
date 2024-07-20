module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] sr;
    wire [3:0] out_shifted;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            sr <= 4'b0;
        else
            sr <= {sr[2:0], in};
    end

    assign out_shifted = {sr[3], sr[2], sr[1], sr[0]};
    assign out = out_shifted[3];

endmodule
