module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    // Declare the 8-bit register to store the state
    reg [7:0] Q;
    wire [2:0] select;
    
    // Creating shift register behavior
    always @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S};  // Shift in new bit S into Q[0], shifting everything to the left
        end
    end
    
    // Combine inputs A, B, and C to form the select signal
    assign select = {A, B, C};
    
    // Create a multiplexer to select the output Z based on the value of select
    always @(*) begin
        case (select)
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b002: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case to handle any unforeseen conditions
        endcase
    end

endmodule
