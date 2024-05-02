module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i++) begin
                q[i] <= rule_110(q[i-1], q[i], q[i+1]);
            end
        end
    end

    function wire rule_110(input wire a, input wire b, input wire c);
        wire r;
        case (a, b, c)
            (1, 1, 1) : r = 0;
            (1, 1, 0) : r = 1;
            (1, 0, 1) : r = 1;
            (1, 0, 0) : r = 0;
            (0, 1, 1) : r = 1;
            (0, 1, 0) : r = 1;
            (0, 0, 1) : r = 1;
            (0, 0, 0) : r = 0;
        endcase
        return r;
    endfunction

endmodule