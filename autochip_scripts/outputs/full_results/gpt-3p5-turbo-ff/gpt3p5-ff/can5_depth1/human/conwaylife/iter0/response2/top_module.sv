module top_module(
  input clk,
  input load,
  input [255:0] data,
  output reg [255:0] q);

  reg [255:0] next_q;

  // Always block to update the game state every clock cycle
  always @(posedge clk) begin
    if (load) begin
      // Load initial state
      q <= data;
    end else begin
      // Calculate the next state based on the current state
      for (integer i = 0; i < 256; i = i + 1) begin
        next_q[i] = calculate_next_state(q[i], get_neighbors(i));
      end
      q <= next_q;
    end
  end

  // Function to calculate the number of neighbors for a given cell index
  function integer get_neighbors(input integer index);
    integer neighbors = 0;

    // Get row and column of the cell
    integer row = index / 16;
    integer col = index % 16;

    // Check each neighbor cell
    if (q[index + 16]) neighbors = neighbors + 1; // South
    if (q[index - 16]) neighbors = neighbors + 1; // North
    if (q[index + 1]) neighbors = neighbors + 1; // East
    if (q[index - 1]) neighbors = neighbors + 1; // West

    // Handle wrap-around on toroid
    if (col == 0) begin
      if (q[row * 16 + 15]) neighbors = neighbors + 1; // West neighbor on toroid
    end else if (col == 15) begin
      if (q[row * 16]) neighbors = neighbors + 1; // East neighbor on toroid
    end

    // Check diagonal neighbors
    if (col != 0) begin
      if (q[index + 15]) neighbors = neighbors + 1; // North West
      if (q[index - 17]) neighbors = neighbors + 1; // South West
    end else begin
      if (q[row * 16 + 15 + 15]) neighbors = neighbors + 1; // North West on toroid
      if (q[row * 16 - 1]) neighbors = neighbors + 1; // South West on toroid
    end

    if (col != 15) begin
      if (q[index + 17]) neighbors = neighbors + 1; // North East
      if (q[index - 15]) neighbors = neighbors + 1; // South East
    end else begin
      if (q[row * 16]) neighbors = neighbors + 1; // North East on toroid
      if (q[row * 16 + 1]) neighbors = neighbors + 1; // South East on toroid
    end

    return neighbors;
  endfunction

  // Function to calculate the next state of a cell based on its current state and number of neighbors
  function integer calculate_next_state(input integer current_state, input integer num_neighbors);
    integer next_state;

    if (num_neighbors == 3) begin
      next_state = 1; // Cell becomes 1 with 3 neighbors
    end else if (num_neighbors == 2) begin
      next_state = current_state; // Cell state does not change with 2 neighbors
    end else begin
      next_state = 0; // Cell becomes 0 with 0-1 or 4+ neighbors
    end

    return next_state;
  endfunction

endmodule
