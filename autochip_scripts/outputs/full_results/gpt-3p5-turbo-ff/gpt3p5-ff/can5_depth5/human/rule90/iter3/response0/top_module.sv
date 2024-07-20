module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
);

  reg [511:0] temp_q;

  always @(posedge clk) begin
        if (load) begin
            temp_q <= data;
        end else begin
            temp_q[0] <= temp_q[1] ^ '0;
            temp_q[511] <= '0 ^ temp_q[510];
            for (int i = 1; i < 511; i = i + 1) begin
                temp_q[i] <= temp_q[i-1] ^ temp_q[i+1];
            end
        end
  end

  assign q = temp_q;

endmodule
