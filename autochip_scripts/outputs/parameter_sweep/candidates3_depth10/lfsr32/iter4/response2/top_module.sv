module top_module(
    input wire clk,
    input wire reset,
    output reg [31:0] q
);

    reg [31:0] d;
    reg [31:0] next_q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            next_q <= 32'h1;
        end else begin
            d <= {q[22:0]^q[1]^q[0], q[31:1]};
            next_q <= d;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= next_q;
        end
    end

endmodule
