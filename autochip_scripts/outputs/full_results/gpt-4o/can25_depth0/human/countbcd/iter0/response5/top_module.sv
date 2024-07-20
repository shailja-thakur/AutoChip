module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire carry1, carry2, carry3;

    // Increment logic for the ones place
    always @(posedge clk or posedge reset) begin
        if (reset)
            q[3:0] <= 4'd0;
        else if (q[3:0] == 4'd9) 
            q[3:0] <= 4'd0;
        else 
            q[3:0] <= q[3:0] + 1;
    end
    assign carry1 = (q[3:0] == 4'd9);

    // Increment logic for the tens place
    always @(posedge clk or posedge reset) begin
        if (reset)
            q[7:4] <= 4'd0;
        else if (carry1) begin
            if (q[7:4] == 4'd9) 
                q[7:4] <= 4'd0;
            else 
                q[7:4] <= q[7:4] + 1;
        end
    end
    assign carry2 = carry1 && (q[7:4] == 4'd9);
    assign ena[1] = carry1;

    // Increment logic for the hundreds place
    always @(posedge clk or posedge reset) begin
        if (reset)
            q[11:8] <= 4'd0;
        else if (carry2) begin
            if (q[11:8] == 4'd9) 
                q[11:8] <= 4'd0;
            else 
                q[11:8] <= q[11:8] + 1;
        end
    end
    assign carry3 = carry2 && (q[11:8] == 4'd9);
    assign ena[2] = carry2;

    // Increment logic for the thousands place
    always @(posedge clk or posedge reset) begin
        if (reset)
            q[15:12] <= 4'd0;
        else if (carry3) begin
            if (q[15:12] == 4'd9) 
                q[15:12] <= 4'd0;
            else 
                q[15:12] <= q[15:12] + 1;
        end
    end
    assign ena[3] = carry3;
    
endmodule
