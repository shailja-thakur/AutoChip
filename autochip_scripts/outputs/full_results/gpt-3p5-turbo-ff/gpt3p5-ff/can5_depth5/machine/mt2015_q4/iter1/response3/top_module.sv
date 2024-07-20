module top_module(
    input x,
    input y,
    output z);

    // Internal wires
    wire a, b;

    // First gate
    and gate_1(a, x, y);

    // Second gate
    and gate_2(b, y, x);

    // Third gate
    and gate_3(z, a, b);

    // Testbench
    initial begin
        // Initialize inputs
        x = 0;
        y = 0;

		// Wait for stability
		#10;

        // Change inputs
        x = 1;
        y = 0;

        // Wait for stability
        #10;

        // Change inputs
        x = 0;
        y = 1;

        // Wait for stability
        #10;

        // Change inputs
        x = 1;
        y = 1;

        // Wait for stability
        #10;

        // Finish simulation
        $finish;
    end
endmodule
