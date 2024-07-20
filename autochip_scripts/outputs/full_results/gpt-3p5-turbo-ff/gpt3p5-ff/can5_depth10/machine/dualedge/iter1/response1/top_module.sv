module top_module(
    input clk,
    input d,
    output reg q
    );
    
    always @(posedge clk) begin
        qp <= d;
    end
    
    always @(negedge clk) begin
        qn <= d;
    end
    
    always @(posedge clk or negedge clk) begin
        if (clk)
            q <= qp;
        else
            q <= qn;
    end
    
    initial begin
        $dumpvars(0, top_module); // Dumping variables for waveform viewer
        $display("Starting simulation");
        $display("clk\td\tq");
        
        clk = 0;
        d = 0;
        #5;
        
        d = 1;
        #5;
        
        d = 0;
        #5;
        
        clk = 1;
        #5;
        
        clk = 0;
        #5;
        
        $display("Simulation finished");
        $finish;
    end  
endmodule
