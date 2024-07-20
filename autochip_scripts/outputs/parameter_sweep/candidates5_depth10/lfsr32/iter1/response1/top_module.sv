module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_temp;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_temp <= 32'h1;
            q <= q_temp;
        end
        else begin
            q_temp[0] <= q_temp[22] ^ q_temp[1] ^ q_temp[0];
            q_temp[31:1] <= {q_temp[30:0]};
            q <= q_temp;
        end
    end

endmodule
