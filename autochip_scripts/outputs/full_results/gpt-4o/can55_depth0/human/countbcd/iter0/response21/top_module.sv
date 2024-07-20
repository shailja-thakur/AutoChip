module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire carry0, carry1, carry2, carry3;

    // Control signals for each digit
    assign ena[1] = carry0;
    assign ena[2] = carry1;
    assign ena[3] = carry2;

    // Increment and carry logic for each BCD digit
    assign carry0 = (q[3:0] == 4'd9);
    assign carry1 = (q[7:4] == 4'd9) && carry0;
    assign carry2 = (q[11:8] == 4'd9) && carry1;
    assign carry3 = (q[15:12] == 4'd9) && carry2;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            if (carry0) begin
                q[3:0] <= 4'd0;
            end else begin
                q[3:0] <= q[3:0] + 1;
            end

            if (carry1) begin
                q[7:4] <= 4'd0;
            end else if (carry0) begin
                q[7:4] <= q[7:4] + 1;
            end

            if (carry2) begin
                q[11:8] <= 4'd0;
            end else if (carry1) begin
                q[11:8] <= q[11:8] + 1;
            end

            if (carry3) begin
                q[15:12] <= 4'd0;
            end else if (carry2) begin
                q[15:12] <= q[15:12] + 1;
            end
        end
    end
endmodule
