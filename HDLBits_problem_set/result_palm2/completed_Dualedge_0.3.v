Here is a Verilog code for a dual-edge triggered flip-flop:

```module dual_edge_triggered_flip_flop (
    input clk,
    input d,
    output q
);

    reg [1:0] state;
    reg [1:0] din;

    always @(posedge clk or negedge clk) begin
        if (rising_edge(clk)) begin
            din <= d;
        end else begin
            state <= state + 1;
        end
    end

    always @(posedge clk) begin
        if (state == 0) begin
            q <= din;
        end else begin
            q <= q;
        end
    end

endmodule
```

This circuit uses two D flip-flops, one positive-edge triggered and one negative-edge triggered. The output of the positive-edge triggered flip-flop is fed to the input of the negative-edge triggered flip-flop, and the output of the negative-edge triggered flip-flop is fed to the input of the positive-edge triggered flip-flop. This ensures that the output of the circuit is updated on both edges of the clock.