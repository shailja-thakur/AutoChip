module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    reg [98:0] both_temp;
    reg [99:0] any_temp;
    reg [99:0] diff_temp;

    always @* begin
        // Calculate out_both
        for (int i = 0; i < 99; i = i + 1) begin
            both_temp[i] = (in[i] == 1) && (in[i+1] == 1);
        end

        // Calculate out_any
        for (int i = 1; i < 100; i = i + 1) begin
            any_temp[i] = (in[i] == 1) || (in[i-1] == 1);
        end

        // Calculate out_different
        diff_temp[99] = (in[99] != in[0]); // Wrap around case
        for (int i = 0; i < 99; i = i + 1) begin
            diff_temp[i] = (in[i] != in[i+1]);
        end
    end

    assign out_both = both_temp;
    assign out_any = any_temp;
    assign out_different = diff_temp;
  
endmodule
