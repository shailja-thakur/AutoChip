module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

    reg [3:0] shift_reg;
    wire [3:0] shifted_data;
    reg [3:0] counter;

    // Shift register section
    always @(posedge clk) begin
        if (shift_ena) begin
            shift_reg <= {data, shift_reg[3:1]};
        end
    end

    // Down counter section
    always @(posedge clk) begin
        if (count_ena) begin
            if (shift_ena && count_ena) begin
                // Handle the case when both control inputs are 1
                counter <= counter - 1;
            end
            else begin
                counter <= shift_reg - 1;
            end
        end
    end

    // Output section
    always @(posedge clk) begin
        if (count_ena) begin
            if (shift_ena && count_ena) begin
                // Handle the case when both control inputs are 1
                q <= counter;
            end
            else begin
                q <= shift_reg;
            end
        end
    end
endmodule
