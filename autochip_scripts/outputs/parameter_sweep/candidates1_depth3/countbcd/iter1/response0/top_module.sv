module top_module(
    input clk,
    input reset,
    output wire [3:1] ena,
    output reg [15:0] q);

    reg [3:0] q0, q1, q2, q3;
    reg [2:0] ena_internal; // Internal enable signals

    always @(posedge clk or posedge reset) begin
        if (reset)
            q0 <= 0;
        else if (ena_internal[0])
            q0 <= q0 + 1;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q1 <= 0;
        else if (ena_internal[1])
            q1 <= q1 + 1;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q2 <= 0;
        else if (ena_internal[2])
            q2 <= q2 + 1;
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q3 <= 0;
        else if (ena_internal[3])
            q3 <= q3 + 1;
    end

    always @(posedge clk) begin
        if (reset)
            ena_internal <= 0;
        else
            ena_internal <= ena;
    end

    assign q = {q3, q2, q1, q0};

endmodule
