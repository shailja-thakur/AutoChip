module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);
    
    // Local signals for enabling each digit counter
    wire ena1, ena2, ena3;

    // Enable signals for each digit counter
    assign ena[1] = ena1;
    assign ena[2] = ena2;
    assign ena[3] = ena3;

    // Ones place counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            q[3:0] <= 4'b0000;
        else if (q[3:0] == 4'b1001)
            q[3:0] <= 4'b0000;
        else
            q[3:0] <= q[3:0] + 1;
    end

    // Enable signal for tens place counter
    assign ena1 = (q[3:0] == 4'b1001);

    // Tens place counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            q[7:4] <= 4'b0000;
        else if (ena1) begin
            if (q[7:4] == 4'b1001)
                q[7:4] <= 4'b0000;
            else
                q[7:4] <= q[7:4] + 1;
        end
    end

    // Enable signal for hundreds place counter
    assign ena2 = ena1 & (q[7:4] == 4'b1001);

    // Hundreds place counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            q[11:8] <= 4'b0000;
        else if (ena2) begin
            if (q[11:8] == 4'b1001)
                q[11:8] <= 4'b0000;
            else
                q[11:8] <= q[11:8] + 1;
        end
    end

    // Enable signal for thousands place counter
    assign ena3 = ena2 & (q[11:8] == 4'b1001);

    // Thousands place counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            q[15:12] <= 4'b0000;
        else if (ena3) begin
            if (q[15:12] == 4'b1001)
                q[15:12] <= 4'b0000;
            else
                q[15:12] <= q[15:12] + 1;
        end
    end

endmodule
