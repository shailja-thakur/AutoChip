module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg [7:0] q,
    output reg Z
);

reg [7:0] next_q;  // Next state of q

always @(posedge clk) begin
    if (enable) begin
        // Shift the S input into the register
        next_q[7] = S;
        next_q[6:0] = q[7:1];
    end else begin
        // Keep the register contents unchanged
        next_q = q;
    end
    
    // Update the register
    q <= next_q;
end

// Select the output bit based on the address formed by A, B, and C inputs
always @(A or B or C or q) begin
    case ({A, B, C})
        3'b000: Z <= q[0];
        3'b001: Z <= q[1];
        3'b010: Z <= q[2];
        3'b011: Z <= q[3];
        3'b100: Z <= q[4];
        3'b101: Z <= q[5];
        3'b110: Z <= q[6];
        3'b111: Z <= q[7];
        default: Z <= 1'b0;  // Default case
    endcase
end

endmodule
