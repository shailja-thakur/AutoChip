module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr;
    wire [3:0] sr_next;

    always @(posedge clk) begin
        if (resetn == 0) begin
            sr <= 4'b0000;
        end else begin
            sr <= sr_next;
        end
    end

    assign sr_next[3] = in;
    assign sr_next[2:0] = sr[3:1];
    assign out = sr[2];

endmodule
