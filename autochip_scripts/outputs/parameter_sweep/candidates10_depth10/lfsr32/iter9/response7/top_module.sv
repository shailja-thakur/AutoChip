module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_delay;
    
    always @(posedge clk) begin
        q_delay <= q;
        if (reset) begin
            q <= 32'h1;
        end else begin
            q <= {q_delay[30:0], q_delay[21:0]^q_delay[1], q_delay[0]};
        end
    end

endmodule
