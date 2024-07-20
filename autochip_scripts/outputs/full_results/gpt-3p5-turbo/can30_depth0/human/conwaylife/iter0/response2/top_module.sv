module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q
);

  reg [255:0] next_q; // next state of the game

  // update the game state at every clock cycle
  always @(posedge clk) begin
    if (load) begin
      q <= data; // load initial state
    end else begin
      q <= next_q; // update game state
    end
  end

  // calculate next state of the game
  always @* begin
    integer i, j;

    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        integer count;

        // count the number of neighbors
        count = q[((i+15)%16)*16+((j+1)%16)] + q[((i+15)%16)*16+j] + q[((i+15)%16)*16+((j+15)%16)] +
                q[(i*16+((j+1)%16))%256] + q[(i*16+j)%256] + q[(i*16+((j+15)%16))%256] +
                q[((i+1)%16)*16+((j+1)%16)] + q[((i+1)%16)*16+j] + q[((i+1)%16)*16+((j+15)%16)];

        // determine the next state based on the number of neighbors
        if (count <= 1) begin
          next_q[i*16+j] = 0;
        end else if (count == 2) begin
          next_q[i*16+j] = q[i*16+j];
        end else if (count == 3) begin
          next_q[i*16+j] = 1;
        end else begin
          next_q[i*16+j] = 0;
        end
      end
    end
  end

endmodule
