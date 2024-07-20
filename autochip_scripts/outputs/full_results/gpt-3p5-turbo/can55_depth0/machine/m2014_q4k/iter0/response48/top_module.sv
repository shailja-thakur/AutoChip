module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr;
    reg [3:0] sr_next;

    always @(posedge clk) begin
        if (resetn == 0) begin
           sr <= 4'b0000;
        end else begin
           sr <= sr_next;
        end
    end

    always @(posedge clk) begin
        sr_next[3:1] <= sr[2:0];
        sr_next[0] <= in;
    end

    assign out = sr[3];

endmodule
