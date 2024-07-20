module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Internal wire declarations
    wire [511:0] next_q;
  
    // Next state logic
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end
  
    // Rule 110 logic
    genvar i;
    generate
        for (i = 0; i < 512; i = i + 1) begin
            always @(*) begin
                if (i == 0) begin
                    next_q[0] = (q[1] & ~q[0]) | (~q[1] & q[0]);
                end else if (i == 511) begin
                    next_q[511] = (q[510] & ~q[511]) | (~q[510] & q[511]);
                end else begin
                    next_q[i] = (q[i-1] & q[i] & q[i+1]) | (q[i-1] & ~q[i] & ~q[i+1]) | (~q[i-1] & ~q[i] & q[i+1]) | (~q[i-1] & ~q[i] & ~q[i+1]);
                end
            end
        end
    endgenerate

endmodule
