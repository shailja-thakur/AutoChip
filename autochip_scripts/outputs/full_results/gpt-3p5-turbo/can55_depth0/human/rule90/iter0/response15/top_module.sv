module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    wire [511:0] left;
    wire [511:0] right;
    
    reg [511:0] q_next;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end
    
    assign left[511:0] = {0, q[511:0]};
    assign right[511:0] = {q[510:0], 0};
    
    always @* begin
        for (integer i = 0; i < 512; i = i + 1) begin
            case ({left[i], q[i], right[i]})
                3'b111: q_next[i] = 1; // Left | Center | Right = 1 | 1 | 1
                3'b110: q_next[i] = 1; // Left | Center | Right = 1 | 1 | 0
                3'b101: q_next[i] = 0; // Left | Center | Right = 1 | 0 | 1
                3'b100: q_next[i] = 1; // Left | Center | Right = 1 | 0 | 0
                3'b011: q_next[i] = 1; // Left | Center | Right = 0 | 1 | 1
                3'b010: q_next[i] = 0; // Left | Center | Right = 0 | 1 | 0
                3'b001: q_next[i] = 1; // Left | Center | Right = 0 | 0 | 1
                3'b000: q_next[i] = 0; // Left | Center | Right = 0 | 0 | 0
            endcase
        end
    end
endmodule
