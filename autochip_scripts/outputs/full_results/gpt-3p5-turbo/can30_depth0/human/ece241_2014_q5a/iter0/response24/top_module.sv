module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [31:0] counter;
reg [31:0] adder_out;
reg [31:0] complement_out;
reg [31:0] prev_x;
reg [31:0] z_reg;

always @(posedge clk, posedge areset)
begin
    if(areset)
    begin
        counter <= 0;
        complement_out <= 0;
        adder_out <= 0;
        prev_x <= 0;
        z_reg <= 0;
    end
    else
    begin
        if(x != prev_x)
        begin
            counter <= counter + 1;
            complement_out <= ~x + 1;
            adder_out <= adder_out + (x - prev_x);
            prev_x <= x;
            z_reg <= complement_out;
        end
    end
end

assign z = z_reg;

endmodule
