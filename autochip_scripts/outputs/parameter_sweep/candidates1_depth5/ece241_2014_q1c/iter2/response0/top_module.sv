module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

    reg [8:0] sum;
    reg signed [9:0] sum_extend;
    wire signed [9:0] a_extend;
    wire signed [9:0] b_extend;

    assign a_extend = {{2{!a[7]}}, a};
    assign b_extend = {{2{!b[7]}}, b};

    always @ (a or b) begin
        sum_extend = a_extend + b_extend;
        sum = sum_extend[8:0];
        
        // Detect overflow
        if (sum_extend[9] == 1'b1 || sum_extend[9] == 1'b0 && a_extend[9] != b_extend[9])
            overflow = 1'b1;
        else
            overflow = 1'b0;
    end

    assign s = sum;

endmodule
