module top_module (
   input a,
   input b,
   output sum,
   output cout
);
   wire [1:0] temp_sum;
   wire temp_cout;
   
   assign temp_sum = a + b;
   assign sum = temp_sum[0];
   assign cout = temp_sum[1];
   
endmodule
