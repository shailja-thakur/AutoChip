module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);

    // Internal Signals
    reg [63:0] shift_data;
    reg [63:0] q_reg;
    
    always @(posedge clk) begin
        if (load) begin
            shift_data <= data;
        end else if (ena) begin
            case(amount)
                2'b00: shift_data <= shift_data << 1;
                2'b01: shift_data <= shift_data << 8;
                2'b10: shift_data <= shift_data >> 1; // Use logical right shift
                2'b11: shift_data <= shift_data >> 8; // Use logical right shift
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (load) begin
            q_reg <= data;
        end else begin
            q_reg <= shift_data;
        end
    end
    
    always @(posedge clk) begin
        q <= q_reg;
    end
endmodule
