module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Temporary registers to hold the next state calculation
    reg [15:0][15:0] next_state;
    reg [15:0][15:0] q_matrix;
    integer i, j;

    // Convert 1D array to 2D array
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                q_matrix[i][j] = q[i*16 + j];
            end
        end
    end

    // Calculate next state based on current state
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer alive_neighbors;
                alive_neighbors = q_matrix[(i - 1) & 15][(j - 1) & 15]
                                + q_matrix[(i - 1) & 15][j]
                                + q_matrix[(i - 1) & 15][(j + 1) & 15]
                                + q_matrix[i][(j - 1) & 15]
                                + q_matrix[i][(j + 1) & 15]
                                + q_matrix[(i + 1) & 15][(j - 1) & 15]
                                + q_matrix[(i + 1) & 15][j]
                                + q_matrix[(i + 1) & 15][(j + 1) & 15];

                case (alive_neighbors)
                    0, 1: next_state[i][j] = 0;
                    2: next_state[i][j] = q_matrix[i][j];
                    3: next_state[i][j] = 1;
                    default: next_state[i][j] = 0;
                endcase
            end
        end
    end

    // Load data or update q at every clock edge
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    q[i*16 + j] <= next_state[i][j];
                end
            end
        end
    end
endmodule
