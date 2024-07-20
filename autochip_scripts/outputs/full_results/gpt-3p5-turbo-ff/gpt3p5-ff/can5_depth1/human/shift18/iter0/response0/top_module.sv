module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            case (amount)
                2'b00: q <= {q[62:0], q[63]}; // Shift left by 1 bit
                2'b01: q <= {q[55:0], data[63:56]}; // Shift left by 8 bits
                2'b10: q <= {q[0], q[63:1]}; // Shift right by 1 bit
                2'b11: q <= {data[7:0], q[63:8]}; // Shift right by 8 bits
            endcase
        end
    end

endmodule
