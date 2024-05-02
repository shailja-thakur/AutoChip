module top_module (
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [64:0] q);

    reg [63:0] shift_reg;
    reg [63:0] shift_amount;
    reg [63:0] shift_data;

    // Load the shift register with data when load is asserted.
    always @(posedge clk or negedge reset) begin
        if (load) begin
            shift_reg <= data;
        end
    end

    // Shift the shift register when ena is asserted.
    always @(posedge clk or negedge reset) begin
        if (ena) begin
            if (amount == 2'b00) begin
                shift_reg <= shift_reg << 1;
            end else if (amount == 2'b01) begin
                shift_reg <= shift_reg << 8;
            end else if (amount == 2'b10) begin
                shift_reg <= shift_reg >> 1;
            end else if (amount == 2'b11) begin
                shift_reg <= shift_reg >> 8;
            end
        end
    end

    // The shift amount is the number of bits to shift the shift register by.
    always @(posedge clk or negedge reset) begin
        if (ena) begin
            shift_amount <= amount;
        end
    end

    // The shift data is the data to be shifted into the shift register.
    always @(posedge clk or negedge reset) begin
        if (ena) begin
            shift_data <= data;
        end
    end

    // The output of the shift register is q.
    assign q = shift_reg;

endmodule