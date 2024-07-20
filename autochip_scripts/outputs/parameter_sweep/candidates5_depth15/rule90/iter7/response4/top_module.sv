module top_module_tb();

    reg clk;
    reg load;
    reg [511:0] data;
    wire [511:0] q;
    reg [511:0] expected_q;

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
        expected_q = 0;

        #5 load = 1;
        #5 data = 512'b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
        #5 load = 0;

        #103 $finish;
    end

    always begin
        #2 clk = ~clk;
    end

    always @(posedge clk) begin
        if (!load) begin
            if (q !== expected_q) begin
                $display("[ERROR] q does not match expected_q at time %t", $time);
                $finish;
            end
            expected_q[0] = ~q[0] & q[1];
            for (integer i = 1; i < 511; i = i + 1) begin
                expected_q[i] = q[i-1] ^ (~q[i] & q[i+1]);
            end
            expected_q[511] = q[510] & ~q[511];
        end
    end

endmodule
