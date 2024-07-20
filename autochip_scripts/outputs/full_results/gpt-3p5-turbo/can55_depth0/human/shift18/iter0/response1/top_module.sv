module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

// Internal signals
reg [63:0] q_temp;

// Synchronous load
always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        // Shift left by 1 bit
        if (ena && (amount == 2'b00)) begin
            q_temp[62:0] <= q[63:1];
            q_temp[63] <= q[63];
        end
        // Shift left by 8 bits
        if (ena && (amount == 2'b01)) begin
            q_temp[55:0] <= q[63:8];
            q_temp[63:56] <= q[63:56];
        end
        // Shift right by 1 bit (arithmetic)
        if (ena && (amount == 2'b10)) begin
            q_temp[63] <= q[0];
            q_temp[62:0] <= q[63:1];
        end
        // Shift right by 8 bits (arithmetic)
        if (ena && (amount == 2'b11)) begin
            q_temp[63:8] <= q[55:0];
            q_temp[7:0] <= q[7:0];
        end
        
        q <= q_temp;
    end
end

endmodule
