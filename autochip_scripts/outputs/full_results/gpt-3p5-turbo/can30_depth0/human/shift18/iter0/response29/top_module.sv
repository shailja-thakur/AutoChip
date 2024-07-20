module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

reg [63:0] shifted_data;
always @(posedge clk) begin
    if (load) begin
        shifted_data <= data;
    end else if (ena) begin
        case(amount)
            2'b00: shifted_data <= {shifted_data[62:0], shifted_data[63]};
            2'b01: shifted_data <= {shifted_data[55:0], shifted_data[63:56]}; 
            2'b10: shifted_data <= {shifted_data[0], shifted_data[63:1]};
            2'b11: shifted_data <= {shifted_data[7:0], shifted_data[63:8]};
            default: shifted_data <= shifted_data;
        endcase
    end
end

assign q = shifted_data;

endmodule
