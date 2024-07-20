module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    reg [511:0] next_q;

    always @(*) begin
        integer i;
        next_q[0] = (q[1]) ? 1 : 0; // Boundary condition for the leftmost cell
        for (i = 1; i < 511; i = i + 1) begin
            case ({q[i+1], q[i], q[i-1]})
                3'b111: next_q[i] = 0;
                3'b110: next_q[i] = 1;
                3'b101: next_q[i] = 1;
                3'b100: next_q[i] = 0;
                3'b011: next_q[i] = 1;
                3'b010: next_q[i] = 1;
                3'b001: next_q[i] = 1;
                3'b000: next_q[i] = 0;
                default: next_q[i] = 0; // Should not happen
            endcase
        end
        next_q[511] = (q[510]) ? 1 : 0; // Boundary condition for the rightmost cell
    end
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

endmodule
