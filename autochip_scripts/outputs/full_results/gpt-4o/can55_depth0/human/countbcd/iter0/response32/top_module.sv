module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Wires for digit enable signals
    wire ena1, ena2, ena3;
    
    assign ena[1] = ena1;
    assign ena[2] = ena2;
    assign ena[3] = ena3;

    // Define enablers conditions
    assign ena1 = (q[3:0] == 4'd9) ? 1 : 0;
    assign ena2 = (q[7:4] == 4'd9 && ena1) ? 1 : 0;
    assign ena3 = (q[11:8] == 4'd9 && ena2) ? 1 : 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end
        else begin
            // Ones place (q[3:0])
            if (q[3:0] == 4'd9)
                q[3:0] <= 4'd0;
            else
                q[3:0] <= q[3:0] + 4'd1;

            // Tens place (q[7:4])
            if (ena1) begin
                if (q[7:4] == 4'd9)
                    q[7:4] <= 4'd0;
                else
                    q[7:4] <= q[7:4] + 4'd1;
            end

            // Hundreds place (q[11:8])
            if (ena2) begin
                if (q[11:8] == 4'd9)
                    q[11:8] <= 4'd0;
                else
                    q[11:8] <= q[11:8] + 4'd1;
            end

            // Thousands place (q[15:12])
            if (ena3) begin
                if (q[15:12] == 4'd9)
                    q[15:12] <= 4'd0;
                else
                    q[15:12] <= q[15:12] + 4'd1;
            end
        end
    end
endmodule
