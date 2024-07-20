module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [31:0] counter;
reg [31:0] pos_result;
reg [31:0] neg_result;
reg [31:0] temp;
reg [31:0] z;

always @(posedge clk, posedge areset)
begin
    if (areset)
    begin
        counter <= 0;
        pos_result <= 0;
        neg_result <= 0;
        temp <= 0;
        z <= 0;
    end
    else if (x)
    begin
        temp <= temp + x;
        counter <= counter + 1;
        
        if (counter == 31)
        begin
            pos_result <= temp;
            neg_result <= ~temp + 1;
            z <= neg_result;
            
            counter <= 0;
            temp <= 0;
        end
    end
end

endmodule
