module top_module(
    input wire clk,
    input wire reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    reg [15:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else
            q <= q_next;
    end

    always @(q) begin
        q_next = q;

        if (ena[1])
            q_next[3:0] = (q[3:0] == 9) ? 4'b0 : q[3:0] + 1;
        if (ena[2])
            q_next[7:4] = (q[7:4] == 9) ? 4'b0 : q[7:4] + 1;
        if (ena[3])
            q_next[11:8] = (q[11:8] == 9) ? 4'b0 : q[11:8] + 1;
    end

    always @(posedge clk) begin
        if (reset)
            ena <= 0;
        else
            ena <= {ena[2:1], 1};
    end
    
endmodule
