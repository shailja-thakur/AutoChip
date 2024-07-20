module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    // Internal wires for neighbouring cells
    wire [511:0] left;
    wire [511:0] right;
    
    // Connect neighbouring cells
    assign left = {q[510:0], 1'b0};
    assign right = {1'b0, q[511:1]};
    
    // Compute the next state for each cell
    always @ (posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i = i + 1) begin
                if (left[i] && q[i] && right[i]) begin
                    q[i] <= 1'b0;
                end else if (left[i] && q[i] && !right[i]) begin
                    q[i] <= 1'b1;
                end else if (left[i] && !q[i] && right[i]) begin
                    q[i] <= 1'b1;
                end else if (left[i] && !q[i] && !right[i]) begin
                    q[i] <= 1'b0;
                end else if (!left[i] && q[i] && right[i]) begin
                    q[i] <= 1'b1;
                end else if (!left[i] && q[i] && !right[i]) begin
                    q[i] <= 1'b1;
                end else if (!left[i] && !q[i] && right[i]) begin
                    q[i] <= 1'b1;
                end else if (!left[i] && !q[i] && !right[i]) begin
                    q[i] <= 1'b0;
                end
            end
        end
    end
    
endmodule
