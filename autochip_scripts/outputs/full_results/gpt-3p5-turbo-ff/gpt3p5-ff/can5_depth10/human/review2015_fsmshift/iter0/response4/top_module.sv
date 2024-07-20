module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [3:0] counter;
    reg [3:0] shift_ena_counter;
    reg enable;

    always @(posedge clk) begin
        if (reset)
            counter <= 0;
        else if (enable)
            counter <= counter + 1;
    end

    always @(posedge clk) begin
        if (reset)
            shift_ena_counter <= 4'b1111;
        else if (enable && counter == 4'b11)
            shift_ena_counter <= 0;
    end

    always @(posedge clk) begin
        enable <= shift_ena_counter != 0;
    end

    assign shift_ena = enable;

endmodule
