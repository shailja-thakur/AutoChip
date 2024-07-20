module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;
    
    // Helper function to compute next state based on Rule 110
    function rule110(input left, input center, input right);
        begin
            rule110 = (left & center & ~right) | (left & ~center & right) | (~left & center & right) | (~left & center & ~right);
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    next_q[i] = rule110(1'b0, q[i], q[i+1]);          // Boundary case for the first cell
                else if (i == 511)
                    next_q[i] = rule110(q[i-1], q[i], 1'b0);          // Boundary case for the last cell
                else
                    next_q[i] = rule110(q[i-1], q[i], q[i+1]);       // General case
            end
            
            q <= next_q;
        end
    end

endmodule
