module top_module (
    input wire clk,
    input wire resetn,
    input wire in,
    output wire out
);

    reg [3:0] sr;

    always @(posedge clk) begin
        if (!resetn) begin
            sr <= 4'b0;
        end else begin
            sr <= {sr[2:0], in};
        end
    end

    assign out = sr[3];

endmodule
