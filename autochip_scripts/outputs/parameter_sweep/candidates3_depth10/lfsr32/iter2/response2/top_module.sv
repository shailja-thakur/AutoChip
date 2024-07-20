module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] feedback;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1;
            feedback <= 0;
        end else begin
            q <= {q[30:0], q[22]^q[1]^q[0]};
            feedback <= {q[21:0], feedback[30:1]};
        end
    end

endmodule
