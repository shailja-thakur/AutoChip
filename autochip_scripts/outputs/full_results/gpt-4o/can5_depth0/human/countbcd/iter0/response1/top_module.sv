module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Internal signals for enable
    reg [3:0] digit0, digit1, digit2, digit3;
    reg ena0, ena1, ena2;

    // ena computation
    assign ena[1] = ena0; // Tens
    assign ena[2] = ena1; // Hundreds
    assign ena[3] = ena2; // Thousands

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            digit0 <= 4'd0;
            digit1 <= 4'd0;
            digit2 <= 4'd0;
            digit3 <= 4'd0;
            ena0 <= 1'b0;
            ena1 <= 1'b0;
            ena2 <= 1'b0;
        end else begin
            // Update ones place digit
            if (digit0 == 4'd9) begin
                digit0 <= 4'd0;
                ena0 <= 1'b1;
            end else begin
                digit0 <= digit0 + 1;
                ena0 <= 1'b0;
            end
            
            // Update tens place digit
            if (ena0) begin
                if (digit1 == 4'd9) begin
                    digit1 <= 4'd0;
                    ena1 <= 1'b1;
                end else begin
                    digit1 <= digit1 + 1;
                    ena1 <= 1'b0;
                end
            end

            // Update hundreds place digit
            if (ena1) begin
                if (digit2 == 4'd9) begin
                    digit2 <= 4'd0;
                    ena2 <= 1'b1;
                end else begin
                    digit2 <= digit2 + 1;
                    ena2 <= 1'b0;
                end
            end

            // Update thousands place digit
            if (ena2) begin
                if (digit3 == 4'd9) begin
                    digit3 <= 4'd0;
                end else begin
                    digit3 <= digit3 + 1;
                end
            end
        end
    end

    always @(*) begin
        q = {digit3, digit2, digit1, digit0};
    end
endmodule
