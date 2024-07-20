module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] counter;
reg [7:0] result;
reg state;

parameter IDLE = 1'b0;
parameter CONVERT = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter <= 8'b0;
        result <= 8'b0;
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONVERT;
                    counter <= 8'b0;
                    result <= 8'b0;
                end
            end
            CONVERT: begin
                if (counter == 8'd7) begin
                    z <= ~result[7] + 1'b1; // Output 2's complement
                    state <= IDLE;
                end
                else begin
                    result <= {result[6:0], x}; // Shift in new bit
                    counter <= counter + 8'd1;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
