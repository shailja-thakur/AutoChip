module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    
    reg [31:0] counter;
    reg [31:0] sum;
    reg [31:0] neg_x;
    reg [31:0] temp;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 0;
            sum <= 0;
            neg_x <= 0;
            temp <= 0;
        end else begin
            if (counter == 0) begin
                neg_x <= ~x + 1;
                sum <= neg_x;
                temp <= neg_x;
                counter <= counter + 1;
            end else if (counter < 31) begin
                neg_x <= temp << 1;
                temp <= neg_x;
                sum <= sum + neg_x;
                counter <= counter + 1;
            end else if (counter == 31) begin
                z <= sum;
                counter <= counter + 1;
            end else begin
                counter <= 0;
            end
        end
    end
endmodule
