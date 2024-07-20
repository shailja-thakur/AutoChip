module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] q_next;

  // Define the toroid grid size
  parameter GRID_SIZE = 16;

  // Generate the row indices
  genvar i;
  generate
    for (i = 0; i < GRID_SIZE; i = i + 1) begin : ROW
      reg [GRID_SIZE-1:0] q_row_next;
      assign q_row_next = (load) ? data[i*GRID_SIZE +: GRID_SIZE] : q[i*GRID_SIZE +: GRID_SIZE];

      // Process cell updates
      always @(posedge clk) begin
        if (load) begin
          q[i*GRID_SIZE +: GRID_SIZE] <= q_row_next;
        end else begin
          integer j;
          for (j = 0; j < GRID_SIZE; j = j + 1) begin : CELL
            integer n;
            reg [3:0] num_neighbors;

            // Compute the number of neighbors
            num_neighbors = q[((i-1+GRID_SIZE) % GRID_SIZE)*GRID_SIZE + ((j-1+GRID_SIZE) % GRID_SIZE)] +
                            q[((i-1+GRID_SIZE) % GRID_SIZE)*GRID_SIZE + j] +
                            q[((i-1+GRID_SIZE) % GRID_SIZE)*GRID_SIZE + ((j+1) % GRID_SIZE)] +
                            q[i*GRID_SIZE + ((j-1+GRID_SIZE) % GRID_SIZE)] +
                            q[i*GRID_SIZE + ((j+1) % GRID_SIZE)] +
                            q[((i+1) % GRID_SIZE)*GRID_SIZE + ((j-1+GRID_SIZE) % GRID_SIZE)] +
                            q[((i+1) % GRID_SIZE)*GRID_SIZE + j] +
                            q[((i+1) % GRID_SIZE)*GRID_SIZE + ((j+1) % GRID_SIZE)];

            // Update the cell state based on the number of neighbors
            case (num_neighbors)
              0, 1: q_row_next[j] <= 0;
              2: q_row_next[j] <= q[i*GRID_SIZE + j];
              3: q_row_next[j] <= 1;
              default: q_row_next[j] <= 0;
            endcase
          end
        end
      end
    end
  endgenerate

  // Assign the next state to the current state at the next clock edge
  always @(posedge clk) begin
    if (load) begin
      q <= q_next;
    end
  end

endmodule
