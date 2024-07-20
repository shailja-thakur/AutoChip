module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (integer i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    q[i] <= (~q[i] & q[i+1]);
                end else if (i == 511) begin
                    q[i] <= (q[i-1] & ~q[i]);
                end else begin
                    q[i] <= (q[i-1] ^ (~q[i] & q[i+1]));
                end
            end
        end
    end

endmodule
module top_module_tb ();
    
    reg clk;     
    reg load;
    reg [511:0] data;
    wire [511:0] q;

    // Instantiate the top_module
    top_module dut (
        .clk(clk),
        .load(load),
        .data(data),
        .q(q)
    );
    
    // Clock
    always
        forever #5 clk = ~clk;
    
    // Initialize inputs
    initial begin
        clk = 0;
        load = 0;
        data = 512'b0;
        
        // Wait for 10 clock cycles
        #50;
        
        // Load initial state
        load = 1;
        data = 512'b1100; // Set some initial state
        
        // Wait for 10 clock cycles
        #50;
        
        // Disable loading and simulate 512 time steps
        load = 0;
        
        // Repeat 512 times
        repeat (512) begin
            #10;
        end
        
        // Finish simulation
        $finish;
    end
    
endmodule
