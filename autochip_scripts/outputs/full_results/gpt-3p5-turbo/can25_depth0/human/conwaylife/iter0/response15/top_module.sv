module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] next_q; // temp register to store the next state of q

  always @(posedge clk) begin
    if (load) begin   // if load is high
      q <= data;      // load the data into q
    end else begin    // if load is low
      q <= next_q;    // update q with the next state
    end
  end

  always @* begin
    for (int i = 0; i < 16; i = i+1) begin
      for (int j = 0; j < 16; j = j+1) begin
        int count = 0;

        if (q[16*(i-1)+j-1]) count = count + 1; // top left
        if (q[16*(i-1)+j])  count = count + 1; // top middle
        if (q[16*(i-1)+j+1]) count = count + 1; // top right
        if (q[16*i+j-1])     count = count + 1; // left
        if (q[16*i+j+1])     count = count + 1; // right
        if (q[16*(i+1)+j-1]) count = count + 1; // bottom left
        if (q[16*(i+1)+j])   count = count + 1; // bottom middle
        if (q[16*(i+1)+j+1]) count = count + 1; // bottom right

        if (count < 2 || count >= 4) begin
          next_q[16*i+j] = 0;  // if 0-1 or 4+ neighbors, cell becomes 0
        end else if (count == 3) begin
          next_q[16*i+j] = 1;  // if 3 neighbors, cell becomes 1
        end else begin
          next_q[16*i+j] = q[16*i+j];  // if 2 neighbors, cell state does not change
        end
      end
    end
  end
endmodule
