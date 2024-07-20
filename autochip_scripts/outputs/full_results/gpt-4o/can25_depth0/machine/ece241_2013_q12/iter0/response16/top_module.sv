module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);
    reg [7:0] q;
    wire [2:0] addr;
    
    // Shift register logic
    always @(posedge clk) begin
        if (enable) begin
            q <= {q[6:0], S};
        end
    end
    
    // Combine A, B, and C to form a 3-bit address
    assign addr = {A, B, C};
    
    // Multiplexer logic
    always @(*) begin
        case (addr)
            3'b000: Z = q[0];
            3'b001: Z = q[1];
            3'b002: Z = q[2];
            3'b003: Z = q[3];
            3'b004: Z = q[4];
            3'b005: Z = q[5];
            3'b006: Z = q[6];
            3'b007: Z = q[7];
            default: Z = 1'b0;
        endcase
    end

endmodule
