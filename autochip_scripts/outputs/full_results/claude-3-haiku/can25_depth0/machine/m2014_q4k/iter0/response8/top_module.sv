module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
);

    reg [3:0] sr;

    always @(posedge clk) begin
        if (!resetn) begin
            sr <= 4'b0000;
        end else begin
            sr <= {sr[2:0], in};
        end
    end

    assign out = sr[3];

endmodule
