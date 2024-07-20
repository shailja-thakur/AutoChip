module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [7:0] sum;
    reg signed [8:0] sum_extend;
    wire signed [8:0] a_extend;
    wire signed [8:0] b_extend;
    
    assign a_extend = {{!a[7], a}};
    assign b_extend = {{!b[7], b}};

    always @ (a or b) begin
        sum_extend = a_extend + b_extend;
        sum = sum_extend[7:0];
    end

    assign s = sum;

    always @ (sum_extend[8]) begin
        overflow = (sum_extend[8] != sum_extend[7]);
    end

endmodule
