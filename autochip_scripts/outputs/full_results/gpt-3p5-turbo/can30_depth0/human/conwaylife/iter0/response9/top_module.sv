module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    wire [255:0] q_next;
    
    // Data input
    reg [255:0] data_reg;
    always @(posedge clk) begin
        if (load) begin
            data_reg <= data;
        end
    end

    // Neighbours count
    reg [255:0] neighbours_count;
    always @* begin
        neighbours_count[0] = q[1] + q[15] + q[16] + q[255] + q[240] + q[31] + q[32] + q[17];
        for (int i = 1; i < 255; i = i+16) begin
            neighbours_count[i] = q[i-15] + q[i+1] + q[i+16] + q[i-16] + q[i-1] + q[i-16+15] + q[i+1+15] + q[i+16+15]; 
        end
        neighbours_count[255] = q[254] + q[0] + q[15] + q[239] + q[224] + q[15+16] + q[0+1] + q[0+16];
    end
    
    // Next state logic
    always @* begin
        for (int i = 0; i < 256; i = i + 1) begin
            case (neighbours_count[i])
                0, 1: q_next[i] = 0;
                2: q_next[i] = q[i];
                3: q_next[i] = 1;
                default: q_next[i] = 0;
            endcase
        end
    end

    // Output register
    always @(posedge clk) begin
        q <= q_next;
    end

endmodule
