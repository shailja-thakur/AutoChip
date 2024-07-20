module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);
    reg [15:0] q_next;

    always @(posedge clk) begin
        if (reset)
            q_next <= 16'b0000;
        else if (ena[1] && q[3:0] == 4'b1001)
            q_next[3:0] <= 4'b0000;
        else if (ena[2] && q[7:4] == 4'b1001)
            q_next[7:4] <= 4'b0000;
        else if (ena[3] && q[11:8] == 4'b1001)
            q_next[11:8] <= 4'b0000;
        else
            q_next <= q + 4'b0001;
    end

    always @(posedge clk) begin
        if (reset)
            ena <= 3'b000;
        else 
            ena <= {q_next[15:13]} != 3'b111;
    end
    
    always @(posedge clk) begin
        if (reset)
            q <= 16'b0000;
        else
            q <= q_next;
    end

endmodule
