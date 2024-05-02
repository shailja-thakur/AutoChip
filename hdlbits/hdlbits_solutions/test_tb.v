module top_module_tb;

  reg clk;
  reg in;
  reg reset;
  wire [7:0] out_byte; // Assuming 8-bit based on the number of data values
  reg done;

  // Reference outputs
  reg [7:0] ref_out_byte = 8'h0;
  reg ref_done;

  // Instantiate the unit under test (UUT) - Assuming a dummy UUT called "my_module"
  top_module UUT (
    .clk(clk),
    .in(in),
    .reset(reset),
    .out_byte(out_byte),
    .done(done)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Assuming 10 time unit period based on the hscale and waveform
  end

  // Stimulus
  initial begin
    // Initialize signals
    reset = 0;
    in = 1;

    #110; in = 0;
    #(140-110); in = 1;
    #(160-140); in = 0;

    // Ending simulation after all stimulus
    #(260-160); $finish;
  end

  // Checking outputs against references
  always @(posedge clk) begin
    if(out_byte != ref_out_byte) begin
      $display("Mismatch at time %0d: Yours=%h, Ref=%h", $time, out_byte, ref_out_byte);
    end

    if(done != ref_done) begin
      $display("Mismatch at time %0d: Yours Done=%b, Ref Done=%b", $time, done, ref_done);
    end
  end

endmodule
