module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] next_q;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            next_q <= 32'h1;
        end else begin
            next_q <= {next_q[30] ^ next_q[20] ^ next_q[0], next_q[31:1]};
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
