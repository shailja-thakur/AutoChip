module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] next_state;
  reg [7:0] neighbors;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      for (int i = 0; i < 256; i = i + 1) begin
        neighbors = 0;
        if(i < 240) begin // not in top row
          if (i % 16 != 0) begin // not in left column
            if (q[i - 17] == 1) neighbors = neighbors + 1; // top left 
          end else begin // in left column
            if (q[i + 15] == 1) neighbors = neighbors + 1; // top left (wrap around)
          end
          if ((i + 1) % 16 != 0) begin // not in right column
            if (q[i - 15] == 1) neighbors = neighbors + 1; // top right
          end else begin // in right column
            if (q[i - 31] == 1) neighbors = neighbors + 1; // top right (wrap around)
          end
          if (q[i - 16] == 1) neighbors = neighbors + 1; // top
        end else begin // in top row, wrap around            
          if (i % 16 != 0) begin // not in left column
            if (q[i + 239] == 1) neighbors = neighbors + 1; // top left (wrap around)
          end else begin // in left column
            if (q[i + 255] == 1) neighbors = neighbors + 1; // top left (wrap around)
          end
          if ((i + 1) % 16 != 0) begin // not in right column
            if (q[i + 241] == 1) neighbors = neighbors + 1; // top right (wrap around)
          end else begin // in right column
            if (q[i + 225] == 1) neighbors = neighbors + 1; // top right (wrap around)
          end
          if (q[i - 16] == 1) neighbors = neighbors + 1; // top
        end

        if(i >= 16) begin // not in bottom row
          if (i % 16 != 0) begin // not in left column
            if (q[i - 17] == 1) neighbors = neighbors + 1; // bottom left 
          end else begin // in left column
            if (q[i - 1] == 1) neighbors = neighbors + 1; // bottom left (wrap around)
          end
          if ((i + 1) % 16 != 0) begin // not in right column
            if (q[i + 15] == 1) neighbors = neighbors + 1; // bottom right
          end else begin // in right column
            if (q[i - 15] == 1) neighbors = neighbors + 1; // bottom right (wrap around)
          end
          if (q[i + 16] == 1) neighbors = neighbors + 1; // bottom
        end else begin // in bottom row, wrap around            
          if (i % 16 != 0) begin // not in left column
            if (q[i + 15] == 1) neighbors = neighbors + 1; // bottom left (wrap around)
          end else begin // in left column
            if (q[i + 31] == 1) neighbors = neighbors + 1; // bottom left (wrap around)
          end
          if ((i + 1) % 16 != 0) begin // not in right column
            if (q[i + 1] == 1) neighbors = neighbors + 1; // bottom right (wrap around)
          end else begin // in right column
            if (q[i - 15] == 1) neighbors = neighbors + 1; // bottom right (wrap around)
          end
          if (q[i + 16] == 1) neighbors = neighbors + 1; // bottom
        end

        if (i % 16 != 0) begin // not in left column
          if (q[i - 1] == 1) neighbors = neighbors + 1; // left
        end else begin // in left column
          if (q[i + 15] == 1) neighbors = neighbors + 1; // left (wrap around)
        end

        if ((i + 1) % 16 != 0) begin // not in right column
          if (q[i + 1] == 1) neighbors = neighbors + 1; // right
        end else begin // in right column
          if (q[i - 15] == 1) neighbors = neighbors + 1; // right (wrap around)
        end

        // Apply game of life rules
        if (q[i] == 1 && (neighbors == 2 || neighbors == 3)) begin
          next_state[i] = 1;
        end else if (q[i] == 0 && neighbors == 3) begin
          next_state[i] = 1;
        end else begin
          next_state[i] = 0;
        end
      end
      q <= next_state;
    end
  end
endmodule
