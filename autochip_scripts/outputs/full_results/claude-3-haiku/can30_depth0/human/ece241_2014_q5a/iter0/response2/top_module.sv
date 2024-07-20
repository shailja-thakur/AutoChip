module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] counter;
reg [7:0] complement;
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 0;
        counter <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        if (state == 0) begin // Conversion mode
            if (counter == 8'b0) begin // Input accepted, start conversion
                state <= 1;
                counter <= 8'b1;
                complement <= 0;
            end
            else begin // Accept input bits
                counter <= counter + 1;
                complement <= (complement << 1) | x;
            end
        end
        else begin // Complement mode
            if (counter == 8'b10000000) begin // Conversion complete
                state <= 0;
                counter <= 0;
                z <= ~complement + 1;
            end
            else begin
                counter <= counter << 1;
                complement <= (complement << 1) | 1;
            end
        end
    end
end

endmodule
