module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      reg [511:0] temp_q;
      temp_q[0] = 0;
      temp_q[511] = 0;
      for (int i = 1; i < 511; i = i + 1) begin
        temp_q[i] = q[i-1] ^ q[i+1];
      end
      q <= temp_q;
    end
  end
  
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
    
    #10; // Wait for some time to stabilize the circuit
    
    load = 1; // Load input is set to 1
    
    #20; // Wait for some time
    
    load = 0; // Load input is set to 0
    
    #100; // Wait for some time to allow for simulation
    
    $finish; // End simulation
  end
  
endmodule
