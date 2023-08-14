module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 

    always @(posedge clk or posedge load) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 512; i++) begin
                q[i] <= rule110(q[i-1], q[i], q[i+1]);
            end
        end
    end

    function bit rule110(bit a, bit b, bit c);
        return (a & b) ^ c;
    endfunction

endmodule