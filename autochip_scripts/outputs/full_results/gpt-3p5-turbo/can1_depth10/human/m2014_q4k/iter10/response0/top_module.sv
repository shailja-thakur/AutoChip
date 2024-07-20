module top_module (
    input wire clk,
    input wire resetn,
    input wire in,
    output wire out
);

    // Define D flip-flops
    reg [3:0] d;
    wire [3:0] q;

    // Shift Register Implementation
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            d <= 4'b0;
        end else begin
            d <= {d[2:0], in};
        end
    end

    // Output assignment
    assign out = q[3];

    // Instantiate D flip-flops
    d_flipflop dff0 (.clk(clk), .resetn(resetn), .d(d[0]), .q(q[0]));
    d_flipflop dff1 (.clk(clk), .resetn(resetn), .d(d[1]), .q(q[1]));
    d_flipflop dff2 (.clk(clk), .resetn(resetn), .d(d[2]), .q(q[2]));
    d_flipflop dff3 (.clk(clk), .resetn(resetn), .d(d[3]), .q(q[3]));

    // Instantiate Clock Generator
    tb_clkgen clkgen (.clk(clk));

    // Instantiate Testbench
    initial begin
        // Apply reset
        resetn = 0;
        #10 resetn = 1;

        // Apply inputs and verify outputs
        in = 0;
        #10 in = 1;        // Load 1 into the shift register
        #10 in = 0;
        #10 in = 1;
        #10 in = 0;        // Shift 1 out, 0 in
        #10 in = 1;        // Load 1 into the shift register
        #10 in = 0;
        #10 in = 1;
        #10 in = 0;

        // Expected output: 1010
        // Verify output after each input change
        always @(posedge clk) begin
            if (out !== 1) $display("Mismatch in out at time %t, expected value = 1", $time);
            #10;
            if (out !== 0) $display("Mismatch in out at time %t, expected value = 0", $time);
            #10;
            if (out !== 1) $display("Mismatch in out at time %t, expected value = 1", $time);
            #10;
            if (out !== 0) $display("Mismatch in out at time %t, expected value = 0", $time);
            #10;
        end

        // End simulation
        $finish;
    end

endmodule
module d_flipflop (
    input wire clk,
    input wire resetn,
    input wire d,
    output reg q
);
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule
module tb_clkgen (
    output reg clk
);
    always #5 clk = ~clk;
endmodule
