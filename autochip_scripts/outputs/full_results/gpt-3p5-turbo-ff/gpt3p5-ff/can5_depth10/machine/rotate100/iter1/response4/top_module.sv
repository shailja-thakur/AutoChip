module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena == 2'b01) begin
            q <= q << 1;
        end else if (ena == 2'b10) begin
            q <= q >> 1;
        end
    end
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        
        clk = 0;
        load = 0;
        ena = 0;
        data = 0;
        
        #10;
        
        // Test Case 1: Load data
        load = 1;
        data = 100'b110011;
        #10;
        load = 0;
        
        // Test Case 2: Shift left
        ena = 2'b01;
        #10;
        ena = 0;
        
        // Test Case 3: Shift right
        ena = 2'b10;
        #10;
        ena = 0;
        
        // Add more test cases here
        
        #10;
        $finish;
    end
    
    always @(negedge clk) begin
        $display("q = %b", q);
    end

endmodule
