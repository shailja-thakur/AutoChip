module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [3:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'b1111;
        else if (count == 0)
            count <= 4'b0000;
        else if (detect_bit_pattern()) // implement a function to detect the proper bit pattern
            count <= count - 1;
    end

    assign shift_ena = count > 0;

    function automatic bit detect_bit_pattern;
        // Implement the proper bit pattern detection logic here
        // return 1 if the bit pattern is detected, else return 0
    endfunction

endmodule
