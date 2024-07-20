module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    // Internal wires
    wire [511:0] left;
    wire [511:0] center;
    wire [511:0] right;
    
    // Assign values to left, center, and right based on q
    assign left = {q[510:0], 1'b0};
    assign center = q;
    assign right = {1'b0, q[511:1]};
    
    // Next state logic
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i = i + 1) begin
                case ({left[i], center[i], right[i]})
                    3'b111: q[i] <= 1'b0;
                    3'b110: q[i] <= 1'b1;
                    3'b101: q[i] <= 1'b1;
                    3'b100: q[i] <= 1'b0;
                    3'b011: q[i] <= 1'b1;
                    3'b010: q[i] <= 1'b1;
                    3'b001: q[i] <= 1'b1;
                    3'b000: q[i] <= 1'b0;
                endcase
            end
        end
    end
    
endmodule
