module top_module (
    input clk,
    input resetn,
    input in,
    output reg [3:0] out
);
    reg [3:0] sr;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            sr <= 4'b0;
        else
            sr <= {sr[2:0], in};
    end

    assign out = sr[3];

endmodule
