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
                q[i] <= rule110(q[i], q[i + 1], q[i + 2]);
            end
        end
    end

    function wire rule110(wire in0, wire in1, wire in2);
        case (in0, in1, in2)
            (1, 1, 1) : return 0;
            (1, 1, 0) : return 1;
            (1, 0, 1) : return 1;
            (1, 0, 0) : return 0;
            (0, 1, 1) : return 1;
            (0, 1, 0) : return 1;
            (0, 0, 1) : return 1;
            (0, 0, 0) : return 0;
        endcase
    endfunction

endmodule