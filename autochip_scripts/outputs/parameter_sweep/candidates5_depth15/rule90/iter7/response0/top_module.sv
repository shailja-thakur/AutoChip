module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            next_q[0] = ~q[0] ^ (q[1] & q[2]);
            for (integer i = 1; i < 511; i = i + 1) begin
                next_q[i] = q[i-1] ^ (q[i] & q[i+1]);
            end
            next_q[511] = q[510] ^ (q[511] & ~q[510]);
            q <= next_q;
        end
    end

endmodule
module top_module_tb();

    reg clk;
    reg load;
    reg [511:0] data;
    wire [511:0] q;

    top_module uut(
        .clk(clk),
        .load(load),
        .data(data),
        .q(q)
    );

    initial begin
        clk = 0;
        load = 0;
        data = 0;

        #5 load = 1;
        #5 data = 512'b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
        #5 load = 0;

        #103 $finish;
    end

    always begin
        #2 clk = ~clk;
    end

endmodule
