module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);
    
    // Define internal wires
    wire [63:0] shifted_data;
    wire [63:0] shifted_right_data;
    
    // Shift left or right based on amount
    assign shifted_data = (amount == 2'b00) ? {q[62:0], 1'b0} :
                          (amount == 2'b01) ? {q[55:0], 8'b0} :
                          (amount == 2'b10) ? {1'b0, q[63:1]} :
                          {8'b0, q[63:8]};
    
    // Perform arithmetic right shift
    assign shifted_right_data = (amount == 2'b10) ? {q[63], q[63:1]} :
                               (amount == 2'b11) ? {q[7], q[63:8]} :
                               {q[63], q[63:8]};
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            q <= (amount[0] == 1'b1) ? shifted_data : shifted_right_data;
        end
    end
    
endmodule
