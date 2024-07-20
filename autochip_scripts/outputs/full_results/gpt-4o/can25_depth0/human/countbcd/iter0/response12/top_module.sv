module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire ena1, ena2, ena3;

    assign ena[1] = ena1;
    assign ena[2] = ena2;
    assign ena[3] = ena3;

    // Ones place counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q[3:0] <= 4'd0;
        end else if (q[3:0] == 4'd9) begin
            q[3:0] <= 4'd0;
        end else begin
            q[3:0] <= q[3:0] + 1;
        end
    end

    assign ena1 = (q[3:0] == 4'd9) ? 1 : 0;

    // Tens place counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q[7:4] <= 4'd0;
        end else if (ena1 && q[7:4] == 4'd9) begin
            q[7:4] <= 4'd0;
        end else if (ena1) begin
            q[7:4] <= q[7:4] + 1;
        end
    end

    assign ena2 = (q[7:4] == 4'd9 && ena1) ? 1 : 0;
    
    // Hundreds place counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q[11:8] <= 4'd0;
        end else if (ena2 && q[11:8] == 4'd9) begin
            q[11:8] <= 4'd0;
        end else if (ena2) begin
            q[11:8] <= q[11:8] + 1;
        end
    end

    assign ena3 = (q[11:8] == 4'd9 && ena2) ? 1 : 0;

    // Thousands place counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q[15:12] <= 4'd0;
        end else if (ena3 && q[15:12] == 4'd9) begin
            q[15:12] <= 4'd0;
        end else if (ena3) begin
            q[15:12] <= q[15:12] + 1;
        end
    end

endmodule
